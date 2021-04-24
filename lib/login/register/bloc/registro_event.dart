part of 'registro_bloc.dart';

abstract class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

class RegistroGoogleEvent extends RegistroEvent {
  @override
  List<Object> get props => [];
}

class RegistroNormalEvent extends RegistroEvent {
  final String name;
  final String pass;
  final String email;
  final String casa;
  final String patronus;
  final String varita;

  RegistroNormalEvent({@required this.name, @required this.pass, @required this.email, @required this.casa, @required this.patronus, @required this.varita});

  @override
  List<Object> get props => [name, pass, email,casa,patronus,varita];
}

class PickImageEvent extends RegistroEvent{
  @override
  List<Object> get props => [];
}
