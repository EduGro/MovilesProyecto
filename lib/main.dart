import 'package:proyectoMoviles/login/ingreso.dart';
import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        //primaryColor: PRIMARY_COLOR,
        primarySwatch: PRIMARY_COLOR,
      ),
      home: Ingreso(title: APP_TITLE),
    );
  }
}
