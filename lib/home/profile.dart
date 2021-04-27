import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoMoviles/login/ingreso.dart';
import 'package:proyectoMoviles/utils/constants.dart';

class Profile extends StatefulWidget {
  final String userEmail;
  const Profile({Key key, this.userEmail}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name, email, wand, patronus, casa, profilePic;

  @override
  Future<void> initState() {
    _getUser().then((user) => {print("Get user done")});
    super.initState();
  }

  Future<void> _getUser() async {
    List<QueryDocumentSnapshot> documentList;
    documentList = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: widget.userEmail)
        .limit(1)
        .get()
        .then((value) => value.docs);
    Map<String, dynamic> user = documentList.first.data();
    name = user['name'];
    email = user['email'];
    wand = user['varita'];
    patronus = user['patronus'];
    casa = user['casa'];
    profilePic = user['image'];
    print(profilePic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),*/
        centerTitle: true,
        title: Text("Perfil"),
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
            image: AssetImage('assets/BkgnGryffindorUser.jpg'),
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
                      backgroundImage: NetworkImage(profilePic),
                      minRadius: 20,
                      maxRadius: 50,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    email,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
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
                    casa,
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
                          /*Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Ingreso(title: title)),
                          );*/
                        },
                      ),
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
