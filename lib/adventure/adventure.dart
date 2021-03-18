import 'package:flutter/material.dart';

class Adventure extends StatefulWidget {
  Adventure({Key key}) : super(key: key);

  @override
  _AdventureState createState() => _AdventureState();
}

class _AdventureState extends State<Adventure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aventura"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BkgdForestWide.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Stack(
            children: [
              RotationTransition(
                turns: new AlwaysStoppedAnimation(270 / 360),
                child: new Image(
                  image: AssetImage('assets/PropWand.png'),
                ),
              ),
              //In order to have the complete background image
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(""),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
