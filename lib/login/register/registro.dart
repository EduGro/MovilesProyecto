import 'dart:io';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/home/home.dart';
import 'package:proyectoMoviles/login/ingreso.dart';
import 'package:proyectoMoviles/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'bloc/registro_bloc.dart';

class Registro extends StatefulWidget {
  Registro({Key key}) : super(key: key);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  bool checkedValue = true;
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  File selectedImage;
  String _houseValue, _patronusValue, _wandValue;

  List<String> patronus = ["Gato", "Perro", "Serpiente", "Ratón", "Cuervo", "Zorro", "Venado", "Lobo"];

  List<String> varitas = ["1", "2", "3", "4"];

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
            create: (context) => RegistroBloc(),
            child: BlocConsumer<RegistroBloc, RegistroState>(
              listener: (context, state) {
                if (state is PickedImageState) {
                  selectedImage = state.image;
                }
              },
              builder: (context, state) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: MaterialButton(
                            child: CircleAvatar(
                              backgroundImage: selectedImage != null
                                  ? FileImage(selectedImage)
                                  : NetworkImage(
                                      "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png"),
                              minRadius: 20,
                              maxRadius: 50,
                            ),
                            onPressed: () {
                              BlocProvider.of<RegistroBloc>(context)
                                  .add(PickImageEvent());
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: GoogleAuthButton(
                            onPressed: () {
                              BlocProvider.of<RegistroBloc>(context)
                                  .add(RegistroGoogleEvent());
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
                          padding: new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Nombre Completo",
                                  textAlign: TextAlign.left,
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextField(
                                style: TextStyle(color: Colors.white),
                                controller: nameController,
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
                          padding: new EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
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
                          padding: new EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
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
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.white,
                                child: DropdownButton<String>(
                                  value: _houseValue,
                                  hint: Text("Casa"),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _houseValue = newValue;
                                    });
                                  },
                                  items: <String>['Slytherin', 'Ravenclaw', 'Hufflepuff', 'Gryffindor']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                        style: TextStyle(
                                          color: Colors.black
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                color: Colors.white,
                                child: DropdownButton<String>(
                                  value: _patronusValue,
                                  hint: Text("Patronus"),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _patronusValue = newValue;
                                    });
                                  },
                                  items: patronus.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                        style: TextStyle(
                                          color: Colors.black
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: DropdownButton<String>(
                                value: _wandValue,
                                hint: Text("Varita"),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.black),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _wandValue = newValue;
                                  });
                                },
                                items: varitas.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 15.0, left: 20.0, right: 20.0),
                          child: MaterialButton(
                            color: Colors.black,
                            child: Text(
                              "Registrate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            height: 40,
                            onPressed: () {
                              var email = emailController.text;
                              var pass = passController.text;
                              var name = nameController.text;
                              if (email == "" || pass == "" || name == "" || _houseValue == null || _patronusValue == null || _wandValue == null) {
                                showSnacks("Faltan algunos datos");
                              } else if (checkedValue) {
                                BlocProvider.of<RegistroBloc>(context)
                                    .add(RegistroNormalEvent(name: name, pass: pass, email: email, patronus: _patronusValue, varita: _wandValue, casa: _houseValue));
                                /*Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Home(
                                          title: APP_TITLE, usuario: user)),
                                );*/
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.only(top: 15.0),
                          child: new RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              children: [
                                new TextSpan(
                                  text: '¿Ya tienes una cuenta?\n',
                                  style: new TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                new TextSpan(
                                  text: 'Ingresa',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    fontSize: 18.0,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Ingreso()),
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
              },
            )));
  }
}
