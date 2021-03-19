import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/item_leaderboard.dart';

class leaderboardInfo extends StatefulWidget {
  final itemLeaderboard place;
  leaderboardInfo({
    Key key,
    @required this.place,
  }) : super(key: key);

  @override
  _leaderboardInfoState createState() => _leaderboardInfoState();
}

class _leaderboardInfoState extends State<leaderboardInfo> {
  @override
  Widget build(BuildContext context) {
    var place = widget.place;
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage("${place.profilePic}"),
        ),
        title: Text("${place.nombre}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('${place.houseImage}'),
            ),
            Text("           "),
            Text("${place.score}"),
          ],
        ),
      ),
    );
  }
}
