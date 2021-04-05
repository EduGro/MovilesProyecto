import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/adventure/bloc/adventure_bloc.dart';

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
      body: BlocProvider(
        create: (context) => AdventureBloc(),
        child: BlocConsumer<AdventureBloc, AdventureState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          if (state is StartEvent) {
            return PutText(state.text);
          } else {
            return PutText("Stop");
          }
        }),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Container PutText(String text) {
  return Container(
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
                          bottom: 300, left: 50, right: 50),
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
        ],
      ),
    ),
  );
}
