part of 'house_bloc.dart';

abstract class HouseState extends Equatable {
  const HouseState();

  @override
  List<Object> get props => [];
}

class HouseInitial extends HouseState {}

class TopicsState extends HouseState {
  final List<Map<String, dynamic>> topicsList;

  TopicsState({@required this.topicsList});
  List<Object> get props => [topicsList];
}