import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';

class friendInfo extends StatefulWidget {
  final itemFriends friend;
  friendInfo({
    Key key,
    @required this.friend,
  }) : super(key: key);

  @override
  _friendInfoState createState() => _friendInfoState();
}

class _friendInfoState extends State<friendInfo> {
  @override
  Widget build(BuildContext context) {
    var friend = widget.friend;
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage("${friend.profilePic}"),
      ),
      title: Text("${friend.name}"),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red[300],
        ), 
        onPressed: (){
          setState(() {});
        },
      ),
    ),
    );
  }
}
