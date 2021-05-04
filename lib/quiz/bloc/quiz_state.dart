part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuestionLoadedState extends QuizState {
  final String pregunta;
  final int score;
  final List resp;
  final String correcta;

  QuestionLoadedState({@required this.pregunta, @required this.score, @required this.resp, @required this.correcta});
  @override
  List<Object> get props => [pregunta, score, resp, correcta];
}

class EndQuizState extends QuizState {
  final int score;

  EndQuizState({@required this.score});
  @override
  List<Object> get props => [score];
}
