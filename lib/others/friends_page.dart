import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';
import 'package:proyectoMoviles/others/friend_info.dart';

class FriendsPage extends StatelessWidget {
  final List<itemFriends> friendsList;
  FriendsPage({
    Key key,
    @required this.friendsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Amigos"),
      ),
      backgroundColor: Colors.indigo[700],
      body: ListView.builder(
        itemCount: friendsList.length,
        itemBuilder: (BuildContext context, int index) {
          return friendInfo(
            friend: friendsList[index],
          );
        },
      ),
    );
  }
}