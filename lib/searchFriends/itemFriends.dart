import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';

class ItemsFriends extends StatelessWidget {
  final itemFriends friend;
  ItemsFriends({Key key, @required this.friend}) : super(key: key);

  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Card(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("I suck ${friend.name}"),
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
