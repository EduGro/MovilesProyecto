import 'package:flutter/material.dart';
import 'package:proyectoMoviles/searchFriends/bloc/search_bloc.dart';
import 'package:proyectoMoviles/searchFriends/itemFriends.dart';

// ignore: camel_case_types
class getFriends extends StatefulWidget {
  final user;
  getFriends({Key key, @required this.user}) : super(key: key);

  @override
  _getFriendsState createState() => _getFriendsState();
}

// ignore: camel_case_types
class _getFriendsState extends State<getFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis amigos"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BkgnHogwartsHalls.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FutureBuilder(
                future: SearchBloc().addedFriends(widget.user["email"]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ItemsFriends(
                          friend: snapshot.data[index],
                          user: widget.user,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 100.0,
                                ),
                                Text(
                                  "Usuarios no encontrados",
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
