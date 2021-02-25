import 'package:proyectoMoviles/home/pantalla_principal.dart';
import 'package:proyectoMoviles/login/registro.dart';
import 'package:proyectoMoviles/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Ingreso extends StatefulWidget {
  final String title;
  Ingreso({Key key, this.title}) : super(key: key);

  @override
  _IngresoState createState() => _IngresoState();
}

class _IngresoState extends State<Ingreso> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  final List<Map<String, String>> _listElements = [
    {
      "nombre": "John Doe",
      "pass": "doej",
      "email": "jdoej@gmail.com",
    },
    {
      "nombre": "Jane Doe",
      "pass": "doej",
      "email": "janeDoe@gmail.com",
    },
    {
      "nombre": "Juan Perez",
      "pass": "perj",
      "email": "jperez@gmail.com",
    },
    {
      "nombre": "Emongg",
      "pass": "dva",
      "email": "zarya@gmail.com",
    },
  ];
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: new EdgeInsets.only(top: 100.0),
                child: Icon(
                  Icons.games,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              Container(
                child: Text(
                  'Hogwarts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Container(
                padding:
                    new EdgeInsets.only(top: 75.0, left: 20.0, right: 20.0),
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
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'John Doe',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    new EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
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
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.only(top: 30.0),
                child: MaterialButton(
                  child: Text(
                    "ENTRAR",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  minWidth: 350,
                  height: 50,
                  color: SECONDARY_COLOR,
                  onPressed: () {
                    var email = emailController.text;
                    var pass = passController.text;
                    if (email == "" || pass == "") {
                      showSnacks("Usuario o contraseña faltantes");
                    } else {
                      var probablyPass = _listElements.indexWhere((element) =>
                          element["nombre"] == email &&
                          element["pass"] == pass);
                      if (probablyPass >= 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PantallaPrincipal(),
                          ),
                        );
                      }
                      showSnacks("Usuario o contraseña incorrectos");
                    }
                  },
                ),
              ),
              Container(
                padding: new EdgeInsets.only(top: 40.0),
                child: new RichText(
                  textAlign: TextAlign.center,
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: '¿Olvidaste tu password?',
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
                padding: new EdgeInsets.only(top: 75.0),
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
      ),
    );
  }
}
