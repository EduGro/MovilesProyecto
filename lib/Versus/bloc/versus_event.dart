part of 'versus_bloc.dart';

@immutable
abstract class VersusEvent extends Equatable {}

class StartEvent extends VersusEvent {
  @override
  List<Object> get props => [];
}

class DefendEvent extends VersusEvent {
  @override
  List<Object> get props => [];
}

class AttackEvent extends VersusEvent {
  final int liveAi;
  final int liveP;

  AttackEvent(this.liveAi, this.liveP);
  @override
  List<Object> get props => [this.liveAi, this.liveP];
}

class EndEvent extends VersusEvent {
  @override
  List<Object> get props => [];
}
