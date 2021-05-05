part of 'house_bloc.dart';

abstract class HouseEvent extends Equatable {
  const HouseEvent();

  @override
  List<Object> get props => [];
}

class InitialEvent extends HouseEvent {}

class TopicsEvent extends HouseEvent {
  final String casa;

  TopicsEvent({@required this.casa});
  List<Object> get props => [casa];
}

class AddTopicEvent extends HouseEvent {
  final String casa;
  final String title;
  final String desc;

  AddTopicEvent(
      {@required this.casa, @required this.title, @required this.desc});

  @override
  List<Object> get props => [casa, title, desc];
}

class SearchEvent extends HouseEvent {
  final String keyword;
  final String casa;

  SearchEvent({@required this.keyword, @required this.casa});

  @override
  List<Object> get props => [keyword, casa];
}
