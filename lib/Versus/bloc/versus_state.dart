part of 'versus_bloc.dart';

@immutable
abstract class VersusState extends Equatable {}

class VersusInitial extends VersusState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class VersusStartState extends VersusState {
  final int liveAi;
  final int liveP;

  VersusStartState({@required this.liveAi, @required this.liveP});

  @override
  List<Object> get props => [liveAi, liveP];
}

class VersusPlayerAttackState extends VersusState {
  final int liveAi;
  final int liveP;
  final int endY;
  final int endX;
  final int specialX;
  final int specialY;
  final String texto;

  VersusPlayerAttackState(
      {@required this.liveAi,
      @required this.liveP,
      @required this.endX,
      @required this.endY,
      @required this.specialX,
      @required this.specialY,
      @required this.texto});

  @override
  List<Object> get props => [liveAi, liveP];
}

class VersusAiAttackState extends VersusState {
  final int liveAi;
  final int liveP;

  VersusAiAttackState({@required this.liveAi, @required this.liveP});

  @override
  List<Object> get props => [liveAi, liveP];
}

class VersusEndState extends VersusState {
  final bool winner;
  final String casa;
  final int score;
  VersusEndState(
      {@required this.winner, @required this.casa, @required this.score});

  @override
  List<Object> get props => [winner, casa, score];
}
