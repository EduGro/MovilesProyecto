import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/adventure/bloc/adventure_bloc.dart';

class Adventure extends StatefulWidget {
  final String casa;
  Adventure({Key key, this.casa}) : super(key: key);

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
      body: BlocProvider(
        create: (context) => AdventureBloc(),
        child: BlocConsumer<AdventureBloc, AdventureState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          if (state is AdventureStartState) {
            return PutText(state.text, context, state.score);
          } else if (state is AdventureNextState) {
            return PutText(state.text, context, state.score);
          } else if (state is AdventureGestureState) {
            return GestureAdventure(state, context);
          } else if (state is AdventureEndState) {
            return EndScreen(context, state.casa, state.score);
          } else {
            BlocProvider.of<AdventureBloc>(context)
                .add(StartEvent(casa: widget.casa));
            return Container();
          }
        }),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Container EndScreen(BuildContext context, String casa, int score) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/BkgdForestWide.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
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
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            height: double.infinity,
            alignment: Alignment.center, // This is needed
            child: Stack(
              children: [
                RotationTransition(
                  turns: new AlwaysStoppedAnimation(90 / 360),
                  child: new Image(
                    image: AssetImage('assets/PropScroll.png'),
                    width: 500,
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 300, left: 50, right: 50),
                    child: Text(
                      "Obtuviste $score puntos",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 75.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.center,
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      BlocProvider.of<AdventureBloc>(context)
                          .add(StartEvent(casa: casa));
                    },
                    child: Text("Intentarlo de nuevo",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Regresar al menu principal",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Container PutText(String text, BuildContext context, int score) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/BkgdForestWide.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(24.0),
      child: GestureDetector(
        onTap: (() {
          BlocProvider.of<AdventureBloc>(context).add(NextEvent());
        }),
        child: Stack(
          children: [
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
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: double.infinity,
                alignment: Alignment.topLeft, // This is needed
                child: Image(
                  image: AssetImage('assets/PropPatronus.png'),
                  width: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center, // This is needed
                child: Stack(
                  children: [
                    RotationTransition(
                      turns: new AlwaysStoppedAnimation(90 / 360),
                      child: new Image(
                        image: AssetImage('assets/PropScroll.png'),
                        width: 500,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 250, left: 50, right: 50),
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: Container(
                height: double.infinity,
                alignment: Alignment.bottomLeft, // This is needed
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(290 / 360),
                  child: new Image(
                    image: AssetImage('assets/PropWand.png'),
                    width: 200,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                height: double.infinity,
                alignment: Alignment.bottomRight, // This is needed
                child: new Text(
                  "score: ${score.toString()}",
                  textAlign: TextAlign.right,
                  style: new TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
GestureDetector GestureAdventure(
    AdventureGestureState s, BuildContext context) {
  var initialX, initialY, distanceX, distanceY;
  var banX = true, banY = true;
  var score = 10;
  return GestureDetector(
    onTap: (() {
      //BlocProvider.of<AdventureBloc>(context).add(GestureEvent(3));
    }),
    onPanStart: (DragStartDetails details) {
      initialX = details.globalPosition.dx;
      initialY = details.globalPosition.dy;
      if (s.specialX != -13)
        banX = false;
      else
        banX = true;
      if (s.specialY != -13)
        banY = false;
      else
        banY = true;
    },
    onPanUpdate: (DragUpdateDetails details) {
      distanceX = details.globalPosition.dx - initialX;
      distanceY = details.globalPosition.dy - initialY;
      if (!banX) {
        if (s.specialX >= 0 && distanceX > s.specialX)
          banX = true;
        else if (s.specialX < 0 && distanceX < s.specialX) banX = true;
      }
      if (!banY) {
        if (s.specialY >= 0 && distanceY > s.specialY)
          banY = true;
        else if (s.specialY < 0 && distanceY < s.specialY)
          banY = true; //for special events
      }
    },
    onPanEnd: (DragEndDetails details) {
      initialX = 0.0;
      initialY = 0.0;
      var banFinalX, banFinalY;
      if (s.endX == 53) {
        banFinalX = (distanceX <= 50 && distanceX >= -50);
      } else if (s.endX >= 0) {
        banFinalX = distanceX > s.endX;
      } else {
        banFinalX = distanceX < s.endX ? true : false;
      }
      if (s.endY == 53) {
        banFinalY = (distanceY <= 50 && distanceY >= -50);
      } else if (s.endY >= 0)
        banFinalY = distanceY > s.endY ? true : false;
      else
        banFinalY = distanceY < s.endY ? true : false;
      if (banX && banY && banFinalX && banFinalY) {
        ScaffoldMessenger.of(context)..hideCurrentSnackBar();
        BlocProvider.of<AdventureBloc>(context).add(GestureEvent(score));
      } else if (score > 5) {
        score -= 2;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("Intenta de nuevo"),
            ),
          );
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("No has completado el hechizo"),
            ),
          );
        BlocProvider.of<AdventureBloc>(context).add(GestureEvent(0));
      }
    },
    child: Container(
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
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: double.infinity,
                alignment: Alignment.topLeft, // This is needed
                child: Image(
                  image: AssetImage('assets/PropPatronus.png'),
                  width: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center, // This is needed
                child: Container(
                  child: Stack(
                    children: [
                      Image(
                        image: AssetImage('assets/${s.text}.png'),
                        width: 600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: Container(
                height: double.infinity,
                alignment: Alignment.bottomLeft, // This is needed
                child: RotationTransition(
                  turns: new AlwaysStoppedAnimation(290 / 360),
                  child: new Image(
                    image: AssetImage('assets/PropWand.png'),
                    width: 200,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                height: double.infinity,
                alignment: Alignment.bottomRight, // This is needed
                child: new Text(
                  "score: ${s.score.toString()}",
                  textAlign: TextAlign.right,
                  style: new TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
