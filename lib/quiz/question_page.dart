import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trivia"),
      ),
      backgroundColor: Color.fromARGB(0xFF, 0xEC, 0xE2, 0xC6),
      body: Container(
        child: Column(
          children: [
            Card(
              color: Color.fromARGB(0xFF, 0xEC, 0xE2, 0xC6),
              child: Image.asset(
                'assets/dp_title.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("¿Quién abrió la Cámara de los Secretos?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ), //TODO: cargar preguntas desde BD
            Divider(
              color: Colors.black,
              thickness: 3,
            ),
            Card(
              color: Colors.yellowAccent[700],
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Bellatrix",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: (){}
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.greenAccent[700],
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Dumbledore",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: (){}
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.blueAccent[700],
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Voldemort",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: (){}
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.redAccent[700],
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Harry Potter",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: (){}
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100.0),
              child: Text("Score: 0", //TODO: obtener current score
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}