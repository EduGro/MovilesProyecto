import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String title;
  final Map<String, String> usuario;
  Home({Key key, this.title, this.usuario}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Drawer(
                child: Profile(
                  title: widget.title,
                  usuario: widget.usuario,
                ),
              );
            },
          ),*/
        ],
      ),
    );
  }
}
