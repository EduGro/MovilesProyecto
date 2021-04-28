import 'package:flutter/material.dart';
import 'package:proyectoMoviles/home/profile.dart';

class Home extends StatefulWidget {
  final String userEmail;
  Home({Key key, this.userEmail}) : super(key: key);

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
        title: Text("AAAA"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text("Usuario"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        userEmail: widget.userEmail,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
