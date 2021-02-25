import 'package:flutter/material.dart';
import 'package:proyectoMoviles/login/ingreso.dart';
import 'package:proyectoMoviles/utils/constants.dart';

class Profile extends StatelessWidget {
  final String title;
  final Map<String, String> usuario;
  const Profile({Key key, this.title, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),*/
        centerTitle: true,
        title: Text(usuario.entries.first.value),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 150,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      PROFILE_PICTURE,
                    ),
                    minRadius: 40,
                    maxRadius: 80,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  usuario["nombre"],
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  usuario["email"],
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Casa",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Varita",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
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
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text(PROFILE_LOGOUT),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => Ingreso(title: title)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
