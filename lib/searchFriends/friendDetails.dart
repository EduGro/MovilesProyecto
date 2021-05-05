import 'package:flutter/material.dart';
import 'package:proyectoMoviles/searchFriends/bloc/search_bloc.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';

class FriendDetails extends StatefulWidget {
  final itemFriends friend;
  final user;
  FriendDetails({Key key, @required this.friend, @required this.user})
      : super(key: key);

  @override
  _FriendDetailsState createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  String text;
  @override
  Widget build(BuildContext context) {
    text = widget.friend.isAmigo == 1 ? "Agregar amigo" : "Remover Amigo";
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),*/
        centerTitle: true,
        title: Text(widget.friend.name),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Bkgn${widget.friend.casa}UserLarge.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: widget.friend.profilePic != null
                          ? NetworkImage(widget.friend.profilePic)
                          : NetworkImage(
                              "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png"),
                      minRadius: 20,
                      maxRadius: 50,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.friend.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*Text(
                    "", //widget.user.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),*/
                  Text(
                    "Casa",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.friend.casa,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Varita",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Image(
                    image: AssetImage('assets/PropWand.png'),
                  ),
                  Text(
                    widget.friend.varita,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Patronus",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.friend.patronus,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      color: Colors.white,
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      height: 40,
                      onPressed: () async {
                        if (widget.friend.isAmigo == 1) {
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
                                  content: Text(
                                      "Surgio un error intentelo mas tarde"),
                                ),
                              );
                          }
                        } else {
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
                                  content: Text(
                                      "Surgio un error intentelo mas tarde"),
                                ),
                              );
                          }
                        }
                      },
                    ),
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
