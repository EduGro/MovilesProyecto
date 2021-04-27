import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/home/pantalla_principal.dart';
import 'package:proyectoMoviles/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'bloc/login_bloc.dart';
import 'register/registro.dart';

class Ingreso extends StatefulWidget {
  final String title;
  Ingreso({Key key, this.title}) : super(key: key);

  @override
  _IngresoState createState() => _IngresoState();
}

class _IngresoState extends State<Ingreso> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnacks(String text) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        key: _scaffoldKey,
        body: BlocProvider(
            create: (context) => LoginBloc(),
            child:
                BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
              // TODO: implement listener
            }, builder: (context, state) {
              if (state is EntrarSuccessState) {
                return PantallaPrincipal(
                  userEmail: state.email,
                );
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Image.asset(
                            'assets/logo_white.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Hogwarts',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Times New Roman'),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(
                              top: 30.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Email",
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextField(
                                style: TextStyle(color: Colors.white),
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(
                              top: 15.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Contraseña",
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextField(
                                style: TextStyle(color: Colors.white),
                                controller: passController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(top: 30.0),
                          child: MaterialButton(
                            color: Colors.black,
                            child: Text(
                              "ENTRAR",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            height: 40,
                            onPressed: () {
                              var email = emailController.text;
                              var pass = passController.text;
                              if (email == "" || pass == "") {
                                showSnacks("Usuario o contraseña faltantes");
                              } else {
                                BlocProvider.of<LoginBloc>(context)
                                    .add(EntrarEvent(email: email, pass: pass));
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: GoogleAuthButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginGoogleEvent());
                            },
                            text: "Iniciar sesión con Google",
                            darkMode: false,
                            style: AuthButtonStyle(
                              buttonType: AuthButtonType.secondary,
                              iconType: AuthIconType.secondary,
                            ),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(top: 20.0),
                          child: new RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: '¿Olvidaste tu contraseña?',
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      showSnacks(
                                          "Enviar un email por favor a: esteCorreo@no.existe");
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(top: 30.0),
                          child: new RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: '¿Aún no tienes una cuenta?\n',
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                new TextSpan(
                                  text: 'REGÍSTRATE',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontSize: 15.0,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Registro()),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            })));
  }
}
