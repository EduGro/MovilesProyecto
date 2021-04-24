import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:proyectoMoviles/quiz/question-repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial());
  int min = 0;
  int max;
  Random rnd = new Random();

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    List list = await QuestionsRepository().getQuestions();
    max = list.length;
    int i = min + rnd.nextInt(max - min);

    // TODO: implement mapEventToState
  }
}
