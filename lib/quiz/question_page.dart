import 'package:flutter/material.dart';
import 'question-repository.dart';

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
      body: FutureBuilder(
          future: QuestionsRepository().getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Algo salio mal", style: TextStyle(fontSize: 50)),
              );
            }
            if (snapshot.hasData) {
              var pregunta = snapshot.data[0];
              return Container(
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
                      child: Text(
                        "${pregunta['pregunta']}",
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "${pregunta['posiblesRespuestas'][3]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () async {
                                  var list = await QuestionsRepository()
                                      .getQuestions();
                                      
                                  print(list[1]["posiblesRespuestas"][0]);
                                }),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "${pregunta['posiblesRespuestas'][2]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {}),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "${pregunta['posiblesRespuestas'][1]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {}),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Text(
                                  "${pregunta['posiblesRespuestas'][0]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Text(
                        "Score: 0", //TODO: obtener current score
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child:
                    Text("Cargando pregunta", style: TextStyle(fontSize: 50)),
              );
            }
          }),
    );
  }
}
