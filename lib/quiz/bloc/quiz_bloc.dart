import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
      if (!event.first) {
        list.remove(list[i]);
      }
      if (list.length == 0) {
        print("object");
        yield EndQuizState(score: score);
      } else {
        if (event.fueCorrecta) {
          score += 10;
        }
        max = list.length;
        i = min + rnd.nextInt(max - min);
        yield QuestionLoadedState(
            score: score,
            correcta: list[i]['respuesta'],
            pregunta: list[i]['pregunta'],
            resp: list[i]['posiblesRespuestas']);
      }      
    } else if (event is EndQuizEvent) {
      await _updateScore(event.casa);
      yield EndQuizState(score: score);
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

  Future<void> _updateScore(String inicial) async {
    try {
      var puntos = await FirebaseFirestore.instance
          .collection('casas')
          .get()
          .then((value) => value.docs);
      await FirebaseFirestore.instance
          .collection('casas')
          .doc('3GAIseZjA3cUFxj68lXT')
          .update({"${inicial}": puntos.first.data()[inicial] + score});
    } catch (e) {
      throw e;
    }
  }
}
