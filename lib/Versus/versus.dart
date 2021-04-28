import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/Versus/bloc/versus_bloc.dart';
import 'package:proyectoMoviles/Versus/bloc/versus_bloc.dart';
import 'package:proyectoMoviles/utils/constants.dart';

class Versus extends StatefulWidget {
  Versus({Key key}) : super(key: key);

  @override
  _VersusState createState() => _VersusState();
}

class _VersusState extends State<Versus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aventura"),
      ),
      body: BlocProvider(
        create: (context) => VersusBloc(),
        child: BlocConsumer<VersusBloc, VersusState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is VersusStartState) {
                //return PutText(state.liveP, context, state.liveAi);
                return versusMockUp(context, 100, 100);
              } else if (state is VersusPlayerAttackState) {
                return GestureVersus(state, context);
              } else if (state is VersusAiAttackState) {
                return versusMockUp(context, state.liveAi, state.liveP);
              } else if (state is VersusEndState) {
                return PutText(context, state.winner);
              } else {
                BlocProvider.of<VersusBloc>(context).add(StartEvent());
                return Container();
              }
            }),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Container PutText(BuildContext context, bool winner) {
  String labelText =
      winner ? "Eres un ganador" : "Haz fallado, intentalo de nuevo";
  String wizardAsset = "Wizard";
  wizardAsset += winner ? "Player" : "Ai";
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/BkgnVs2.jpg'),
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
          padding: const EdgeInsets.only(top: 100.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              labelText,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            //height: double.infinity,
            child: Align(
              alignment: FractionalOffset.bottomCenter, // This is needed
              child: Image(
                image: AssetImage('assets/$wizardAsset.png'),
                width: 200,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
GestureDetector GestureVersus(VersusPlayerAttackState s, BuildContext context) {
  var initialX, initialY, distanceX, distanceY;
  var banX = true, banY = true;
  return GestureDetector(
    onTap: (() {
      //BlocProvider.of<VersusBloc>(context).add(GestureEvent(3));
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
        int liveAi = s.liveAi - (15 + Random().nextInt(25));
        liveAi = liveAi > 0 ? liveAi : 0;
        BlocProvider.of<VersusBloc>(context).add(DefendEvent(liveAi, s.liveP));
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("No has completado el hechizo"),
            ),
          );
        BlocProvider.of<VersusBloc>(context)
            .add(DefendEvent(s.liveAi, s.liveP));
      }
    },
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/BkgnVs2.jpg'),
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
            padding: const EdgeInsets.only(left: 200, top: 120),
            child: Container(
              height: 30,
              width: 150,
              child: Align(
                alignment: FractionalOffset.topRight,
                child: FAProgressBar(
                  size: 15,
                  currentValue: s.liveAi,
                  displayText: '',
                  animatedDuration: Duration(milliseconds: 500),
                  progressColor: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50, top: 150),
            child: Container(
              height: double.infinity,
              child: Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage('assets/WizardAi.png'),
                  width: 125,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 250),
            child: Container(
              height: 50,
              width: 175,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FAProgressBar(
                  size: 20,
                  currentValue: s.liveP,
                  displayText: '',
                  animatedDuration: Duration(milliseconds: 500),
                  progressColor: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              //height: double.infinity,
              child: Align(
                alignment: FractionalOffset.bottomLeft, // This is needed
                child: Image(
                  image: AssetImage('assets/WizardPlayer.png'),
                  width: 200,
                ),
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
                      image: AssetImage('assets/${s.texto}.png'),
                      width: 600,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

GestureDetector versusMockUp(BuildContext context, int liveAi, int liveP) {
  return GestureDetector(
    onTap: (() {
      liveP -= 5 + Random().nextInt(20);
      liveP = liveP > 0 ? liveP : 0;
      BlocProvider.of<VersusBloc>(context).add(AttackEvent(liveAi, liveP));
    }),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/BkgnVs2.jpg'),
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
            padding: const EdgeInsets.only(left: 200, top: 120),
            child: Container(
              height: 30,
              width: 150,
              child: Align(
                alignment: FractionalOffset.topRight,
                child: FAProgressBar(
                  size: 15,
                  currentValue: liveAi,
                  displayText: '',
                  animatedDuration: Duration(milliseconds: 500),
                  progressColor: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 50, top: 150),
            child: Container(
              height: double.infinity,
              child: Align(
                alignment: Alignment.topRight,
                child: Image(
                  image: AssetImage('assets/WizardAi.png'),
                  width: 125,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 250),
            child: Container(
              height: 50,
              width: 175,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FAProgressBar(
                  size: 20,
                  currentValue: liveP,
                  displayText: '',
                  animatedDuration: Duration(milliseconds: 500),
                  progressColor: PRIMARY_COLOR,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              //height: double.infinity,
              child: Align(
                alignment: FractionalOffset.bottomLeft, // This is needed
                child: Image(
                  image: AssetImage('assets/WizardPlayer.png'),
                  width: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
