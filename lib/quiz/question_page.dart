import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/home/pantalla_principal.dart';
import 'bloc/quiz_bloc.dart';

class QuizPage extends StatefulWidget {
  final String casa;
  QuizPage({Key key, this.casa}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool checkAnswer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trivia"),
        ),
        backgroundColor: Color.fromARGB(0xFF, 0xEC, 0xE2, 0xC6),
        body: BlocProvider(
            create: (context) => QuizBloc()
              ..add(InitialEvent())
              ..add(NextQuestionEvent(fueCorrecta: false)),
            child: BlocConsumer<QuizBloc, QuizState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is QuestionLoadedState) {
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
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "${state.pregunta}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(
                                      "${state.resp[3]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      checkAnswer = _checkAnswer(
                                          state.resp[3], state.correcta);
                                      BlocProvider.of<QuizBloc>(context).add(
                                          NextQuestionEvent(
                                              fueCorrecta: checkAnswer));
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
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(
                                      "${state.resp[0]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      checkAnswer = _checkAnswer(
                                          state.resp[0], state.correcta);
                                      BlocProvider.of<QuizBloc>(context).add(
                                          NextQuestionEvent(
                                              fueCorrecta: checkAnswer));
                                    }),
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
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(
                                      "${state.resp[2]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      checkAnswer = _checkAnswer(
                                          state.resp[2], state.correcta);
                                      BlocProvider.of<QuizBloc>(context).add(
                                          NextQuestionEvent(
                                              fueCorrecta: checkAnswer));
                                    }),
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
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Text(
                                      "${state.resp[1]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      checkAnswer = _checkAnswer(
                                          state.resp[1], state.correcta);
                                      BlocProvider.of<QuizBloc>(context).add(
                                          NextQuestionEvent(
                                              fueCorrecta: checkAnswer));
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: Text(
                            "Score: ${state.score}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            color: Colors.deepPurple,
                            child: Text(
                              "Terminar ronda",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              BlocProvider.of<QuizBloc>(context).add(
                                  EndQuizEvent(casa: widget.casa));
                              Navigator.of(context).pop();
                            }),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )));
  }

  bool _checkAnswer(String resp, String correcta) {
    return resp == correcta;
  }
}
