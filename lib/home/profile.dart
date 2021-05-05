import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectoMoviles/login/ingreso.dart';
import 'package:proyectoMoviles/utils/constants.dart';

class Profile extends StatefulWidget {
  final bool isGoogle;
  final Map<String, dynamic> user;
  const Profile({Key key, this.isGoogle, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fondo;

  @override
  Widget build(BuildContext context) {
    if (widget.user['casa'] == 'Slytherin')
      fondo = 'assets/BkgnSlytherinUser.jpg';
    else if (widget.user['casa'] == 'Ravenclaw')
      fondo = 'assets/BkgnRavenclawUserLarge.jpg';
    else if (widget.user['casa'] == 'Hufflepuff')
      fondo = 'assets/BkgnHufflepuffUserLarge.jpg';
    else
      fondo = 'assets/BkgnGryffindorUser.jpg';
      
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Perfil"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(fondo),
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
                      backgroundImage: widget.user['image'] != null
                          ? NetworkImage(widget.user['image'])
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
                    widget.user['name'],
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.user['email'],
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                    widget.user['casa'],
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
                    widget.user['varita'],
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
                    widget.user['patronus'],
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
                        "Cerrar sesión",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                      height: 40,
                      onPressed: () async {
                        if (widget.isGoogle) {
                          await GoogleSignIn(scopes: <String>["email"])
                              .signOut();
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Ingreso()),
                        );
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
