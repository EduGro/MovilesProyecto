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

  VersusPlayerAttackState({
    @required this.liveAi,
    @required this.liveP,
    @required this.endX,
    @required this.endY,
    @required this.specialX,
    @required this.specialY,
  });

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
  VersusEndState({@required this.winner});

  @override
  List<Object> get props => [];
}
