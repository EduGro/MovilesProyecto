part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends QuizEvent {}

class NextQuestionEvent extends QuizEvent {
  final bool fueCorrecta;

  NextQuestionEvent({@required this.fueCorrecta});

  @override
  List<Object> get props => [fueCorrecta];
}

class EndQuizEvent extends QuizEvent {
  final String casa;

  EndQuizEvent({@required this.casa});

  @override
  List<Object> get props => [casa];
}