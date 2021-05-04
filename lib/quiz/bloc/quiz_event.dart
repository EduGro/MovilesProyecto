part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends QuizEvent {}

class NextQuestionEvent extends QuizEvent {
  final bool fueCorrecta;
  final bool first;

  NextQuestionEvent({@required this.fueCorrecta, @required this.first});

  @override
  List<Object> get props => [fueCorrecta, first];
}

class EndQuizEvent extends QuizEvent {
  final String casa;

  EndQuizEvent({@required this.casa});

  @override
  List<Object> get props => [casa];
}
