part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EntrarEvent extends LoginEvent {
  final String pass;
  final String email;

  EntrarEvent({@required this.pass, @required this.email});

  @override
  List<Object> get props => [pass, email];
}

class LoginGoogleEvent extends LoginEvent {}
