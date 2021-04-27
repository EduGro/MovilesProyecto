part of 'adventure_bloc.dart';

@immutable
abstract class AdventureState extends Equatable {}

class AdventureInitial extends AdventureState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AdventureStartState extends AdventureState {
  final String text;
  final int score;

  AdventureStartState({@required this.text, @required this.score});

  @override
  List<Object> get props => [text, score];
}

class AdventureNextState extends AdventureState {
  final String text;
  final int score;

  AdventureNextState({@required this.text, @required this.score});

  @override
  List<Object> get props => [text, score];
}

class AdventureGestureState extends AdventureState {
  final String text;
  final int score;
  final int endY;
  final int endX;
  final int specialX;
  final int specialY;

  AdventureGestureState({
    @required this.text,
    @required this.score,
    @required this.endX,
    @required this.endY,
    @required this.specialX,
    @required this.specialY,
  });

  @override
  List<Object> get props => [text, score];
}

class AdventureEndState extends AdventureState {
  AdventureEndState();

  @override
  List<Object> get props => [];
}
