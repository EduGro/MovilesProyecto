part of 'registro_bloc.dart';

abstract class RegistroState extends Equatable {
  const RegistroState();

  @override
  List<Object> get props => [];
}

class RegistroInitial extends RegistroState {}

class RegistroErrorState extends RegistroState {
  final String errorMsg;

  RegistroErrorState({@required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class PickedImageState extends RegistroState {
  final File image;

  PickedImageState({@required this.image});
  @override
  List<Object> get props => [image];
}

class UsuarioRegistradoState extends RegistroState {
  final String email;

  UsuarioRegistradoState({@required this.email});
  @override
  List<Object> get props => [email];
}

class RegistroGoogleState extends RegistroState {
  final String name;
  final String image;

  RegistroGoogleState({@required this.name, @required this.image});
  @override
  List<Object> get props => [name, image];
}

class YaExisteState extends RegistroState {}