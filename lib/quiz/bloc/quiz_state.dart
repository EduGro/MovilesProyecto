part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class QuizStartState extends QuizState {
  final int score;

  QuizStartState({@required this.score});

  @override
  // TODO: implement props
  List<Object> get props => [score];
}
