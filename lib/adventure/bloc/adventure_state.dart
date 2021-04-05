part of 'adventure_bloc.dart';

@immutable
abstract class AdventureState extends Equatable {}

class AdventureInitial extends AdventureState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AdventureStartState extends AdventureState {
  final String text;

  AdventureStartState({@required this.text});

  @override
  // TODO: implement props
  List<Object> get props => [text];
}

class AdventureNextState extends AdventureState {
  final String text;

  AdventureNextState({@required this.text});

  @override
  // TODO: implement props
  List<Object> get props => [text];
}

class AdventureEndState extends AdventureState {
  AdventureEndState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
