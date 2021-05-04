part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class EntrarState extends LoginState {}

class EntrarSuccessState extends LoginState {
  final String email;

  EntrarSuccessState({@required this.email});
  @override
  List<Object> get props => [email];
}

class NoExisteState extends LoginState {}