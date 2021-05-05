import 'package:flutter/material.dart';
import 'package:proyectoMoviles/searchFriends/bloc/search_bloc.dart';
import 'package:proyectoMoviles/searchFriends/itemFriends.dart';

class SearchFriends extends StatefulWidget {
  final user;
  SearchFriends({Key key, @required this.user}) : super(key: key);

  @override
  _SearchFriendsState createState() => _SearchFriendsState();
}

class _SearchFriendsState extends State<SearchFriends> {
  var _controller = TextEditingController();
  var query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar amigos"),
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
            Material(
              child: TextField(
                textInputAction: TextInputAction.search,
                controller: _controller,
                onSubmitted: (value) {
                  query = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: Colors.green[100],
                  filled: true,
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: Icon(Icons.clear),
                  ),
                  hintText: 'Search ',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: FutureBuilder(
                future: SearchBloc().getFriends(query, widget.user["amigos"]),
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
