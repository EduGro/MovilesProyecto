part of 'adventure_bloc.dart';

@immutable
abstract class AdventureEvent extends Equatable {}

class StartEvent extends AdventureEvent {
  @override
  List<Object> get props => [];
}

class NextEvent extends AdventureEvent {
  @override
  List<Object> get props => [];
}

class GestureEvent extends AdventureEvent {
  final int score;

  GestureEvent(this.score);
  @override
  List<Object> get props => [this.score];
}

class EndEvent extends AdventureEvent {
  @override
  List<Object> get props => [];
}
