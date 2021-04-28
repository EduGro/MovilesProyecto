import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial());
  List _questionList;
  int min = 0;
  int max;
  Random rnd = new Random();
  int score = 0;
  int i;
  List list;

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is InitialEvent) {
      list = await _getQuestions();
      max = list.length;
      i = min + rnd.nextInt(max - min);
    } else if (event is NextQuestionEvent) {
      if (event.fueCorrecta) {
        score += 10;
      }
      i = min + rnd.nextInt(max - min);
      yield QuestionLoadedState(
          score: score,
          correcta: list[i]['respuesta'],
          pregunta: list[i]['pregunta'],
          resp: list[i]['posiblesRespuestas']);
    }
  }

  Future<List> _getQuestions() async {
    try {
      var data = await FirebaseFirestore.instance.collection("preguntas").get();
      _questionList = data.docs.toList();
      return _questionList;
    } catch (e) {
      throw e;
    }
  }
}
