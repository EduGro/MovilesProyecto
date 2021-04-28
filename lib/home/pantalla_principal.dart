import 'package:flutter/material.dart';
import 'package:proyectoMoviles/Versus/versus.dart';
import 'package:proyectoMoviles/others/leaderboard_page.dart';
import 'package:proyectoMoviles/profile.dart';
import 'package:proyectoMoviles/others/friends_page.dart';
import 'package:proyectoMoviles/others/house_page.dart';
import 'package:proyectoMoviles/utils/temp_friend_list.dart';
import 'package:proyectoMoviles/utils/temp_leaderboard.dart';
import 'package:proyectoMoviles/utils/temp_topics.dart';
import '../adventure/adventure.dart';
import '../quiz/question_page.dart';

class PantallaPrincipal extends StatefulWidget {
  final String title;
  final Map<String, String> usuario;
  PantallaPrincipal({Key key, this.title, this.usuario}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[700],
      key: _scaffoldKey,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Profile(
                    title: widget.title,
                    usuario: widget.usuario,
                  ),
                ),
              );
            },
          ),
          centerTitle: true,
          title: Text('Bienvenido'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.dehaze),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
            ),
          ]),
      endDrawer: Drawer(
        child: Container(
          color: Colors.indigo[900],
          child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: ListView(
              children: <Widget>[
                Card(
                  color: Colors.purple,
                  child: ListTile(
                    title: Text(
                      "Buscar amigos",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Card(
                  color: Colors.indigo,
                  child: ListTile(
                    title: Text(
                      "Ir a casa",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return HousePage(
                                topicList: TopicRepository.loadTopic());
                          },
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  color: Colors.deepPurple,
                  child: ListTile(
                    title: Text(
                      "Ver leaderboards",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _openLeaderboards();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(children: <Widget>[
        GestureDetector(
          onTap: _openQuiz,
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Modo trivia",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Responde correctamente para ganar puntos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _openAdventure,
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Card(
              color: Colors.teal[300],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Modo aventura",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Haz hechizos y gana puntos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _openVS,
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Card(
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Modo versus",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Compite contra otros jugadores",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _openFriends,
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: MediaQuery.of(context).size.height / 8,
            child: Card(
              color: Colors.purple[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ver amigos",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  void _openQuiz() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return QuizPage();
        },
      ),
    );
  }

  void _openAdventure() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Adventure();
        },
      ),
    );
  }

  void _openVS() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Versus();
        },
      ),
    );
  }

  void _openFriends() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FriendsPage(friendsList: FriendRepository.loadFriends());
        },
      ),
    );
  }

  void _openLeaderboards() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LeaderboardPage(
              leaderboardList: LeaderboardRepository.loadLeaderboard());
        },
      ),
    );
  }
}
