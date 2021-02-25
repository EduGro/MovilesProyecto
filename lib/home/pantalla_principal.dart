import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            
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
        ]
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                  title: Text("Buscar amigos"),
                  onTap: (){},
                ),
            ),
            Card(
              child: ListTile(
                  title: Text("Ir a casa"),
                  onTap: (){},
                ),
            ),
            Card(
              child: ListTile(
                  title: Text("Ver leaderboards"),
                  onTap: (){},
                ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: _openQuiz,
            child: Container(
              padding: EdgeInsets.all(12.0),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                color: Colors.amber,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Modo trivia",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text("Responde correctamente para ganar puntos",
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Modo aventura",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text("Haz hechizos y gana puntos",
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Modo versus",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text("Compite contra otros jugadores",
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
              height: MediaQuery.of(context).size.height * 0.2,
              child: Card(
                color: Colors.purple[400],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ver amigos",
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
        ]
      ),
    );
  }


  void _openQuiz() {
    // TODO
  }
  void _openAdventure() {
    // TODO
  }
  void _openVS() {
    // TODO
  }
  void _openFriends() {
    // TODO
  }
}