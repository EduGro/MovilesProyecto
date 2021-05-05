import 'package:flutter/material.dart';
import 'package:proyectoMoviles/searchFriends/bloc/search_bloc.dart';
import 'package:proyectoMoviles/searchFriends/friendDetails.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';

class ItemsFriends extends StatefulWidget {
  final itemFriends friend;
  final user;

  ItemsFriends({Key key, @required this.friend, @required this.user})
      : super(key: key);

  @override
  _itemFriendsState createState() => _itemFriendsState();
}

// ignore: camel_case_types
class _itemFriendsState extends State<ItemsFriends> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];
  IconData ico1 = Icons.person_add_disabled;
  IconData ico2 = Icons.person_add;
  IconData ico3 = Icons.person_remove;

  @override
  Widget build(BuildContext context) {
    int ban = widget.friend.isAmigo;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 6.0, right: 6.0),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FriendDetails(
                  user: widget.friend,
                );
              },
            ),
          ),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "${widget.friend.profilePic}",
                        height: 75,
                        width: 75,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.friend.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image(
                    image: AssetImage(
                        'assets/PropShield${widget.friend.casa}.png'),
                    width: 50,
                  ),
                ),
                IconButton(
                    icon: Icon(ban == 0
                        ? ico1
                        : ban == 1
                            ? ico2
                            : ico3),
                    onPressed: () async {
                      if (ban == 1) {
                        bool ban1 = await SearchBloc()
                            .addUser(widget.friend.id, widget.user);
                        if (ban1) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("Amigo agregado"),
                              ),
                            );
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content:
                                    Text("Surgio un error intentelo mas tarde"),
                              ),
                            );
                        }
                      } else if (ban == 2) {
                        bool ban1 = await SearchBloc()
                            .deleteUser(widget.friend.id, widget.user);
                        if (ban1) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text("Amigo removido"),
                              ),
                            );
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content:
                                    Text("Surgio un error intentelo mas tarde"),
                              ),
                            );
                        }
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
