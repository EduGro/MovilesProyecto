part of 'versus_bloc.dart';

@immutable
abstract class VersusEvent extends Equatable {}

class StartEvent extends VersusEvent {
  final String casa;

  StartEvent({@required this.casa});

  @override
  List<Object> get props => [casa];
}

class DefendEvent extends VersusEvent {
  final int liveAi;
  final int liveP;

  DefendEvent(this.liveAi, this.liveP);
  @override
  List<Object> get props => [this.liveAi, this.liveP];
}

class AttackEvent extends VersusEvent {
  final int liveAi;
  final int liveP;

  AttackEvent(this.liveAi, this.liveP);
  @override
  List<Object> get props => [this.liveAi, this.liveP];
}

class EndEvent extends VersusEvent {
  final String casa;

  EndEvent({@required this.casa});
  @override
  List<Object> get props => [casa];
}
