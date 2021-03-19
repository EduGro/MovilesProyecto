import 'package:flutter/material.dart';
import 'package:proyectoMoviles/others/leaderboard_info.dart';
import 'package:proyectoMoviles/utils/item_leaderboard.dart';

class LeaderboardPage extends StatelessWidget {
  final List<itemLeaderboard> leaderboardList;
  LeaderboardPage({
    Key key,
    @required this.leaderboardList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
        bottom: PreferredSize(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ButtonTheme(
                    minWidth: 75.0,
                    height: 40.0,
                    buttonColor: Color(0xffC0C0C0),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("GLOBAL"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ButtonTheme(
                    minWidth: 75.0,
                    height: 40.0,
                    buttonColor: Color(0xffC0C0C0),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("HOUSE"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ButtonTheme(
                    minWidth: 75.0,
                    height: 40.0,
                    buttonColor: Color(0xffC0C0C0),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("FRIENDS"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(40.0),
        ),
      ),
      backgroundColor: Colors.indigo[700],
      body: Container(
        child: ListView.builder(
          itemCount: leaderboardList.length,
          itemBuilder: (BuildContext context, int index) {
            return leaderboardInfo(
              place: leaderboardList[index],
            );
          },
        ),
      ),
    );
  }
}
