import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:proyectoMoviles/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:proyectoMoviles/utils/constants.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      appBar: AppBar(
        title: Text("Leaderboards"),
      ),
      body: FutureBuilder(
        future: LeaderboardBloc().getHouse(),
        builder: (context, state) {
          if (state.hasData) {
            return theBody(state.data);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Container theBody(list) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/BkgnVs.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getBar(list[0], list[4], GRYFFINDOR_COLOR),
                    //Si el valor es menor a 100 entonces +10, de lo contrario mas +100
                    //while N % m (inicial 10) sea == 0
                    //  m*10
                    //m/10 = valorMaximo
                    putText("Gryffindor"),
                  ],
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getBar(list[1], list[4], HUFFLEPUFF_COLOR),
                    putText("Hufflepuff"),
                  ],
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getBar(list[2], list[4], RAVENCLAW_COLOR),
                    putText("Ravenclaw"),
                  ],
                ),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    getBar(list[3], list[4], SLYTHERIN_COLOR),
                    putText("Slytherin"),
                  ],
                ),
              ],
            ),
            Text(
              "Casa ganadora al momento: ${list[5]}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Image(
              image: AssetImage('assets/Bkgn${list[5]}UserLarge.jpg'),
              height: 325,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Text putText(String s) {
    return Text(
      s,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }

  Container getBar(int value, int maxValue, Color color) {
    return Container(
      height: 250,
      width: 25,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FAProgressBar(
          size: 100,
          maxValue: maxValue,
          currentValue: value,
          displayText: '',
          animatedDuration: Duration(milliseconds: 1500),
          progressColor: color,
          verticalDirection: VerticalDirection.up,
          direction: Axis.vertical,
        ),
      ),
    );
  }
}
