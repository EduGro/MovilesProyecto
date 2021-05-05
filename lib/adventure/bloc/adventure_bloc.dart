import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'adventure_event.dart';
part 'adventure_state.dart';

class AdventureBloc extends Bloc<AdventureEvent, AdventureState> {
  AdventureBloc() : super(AdventureInitial());
  List<String> list = [
    "Te encuentras caminando por el bosque perdido",
    "Cuando encuentras un arbol pequeño, realiza un hechizo para removerlo",
    "hechizo",
    "7",
    "Con el obstáculo pasado, continuas tu camino",
    "La luz se hace cada vez más tenue conforme te adentras más y más",
    "La atmósfera se torna más sombría mientras varios sonidos inundan el ambiente",
    "Te das cuenta que pocas criaturas pasan por ahí mientras te mantienes alerta",
    "La luz del sol es casi imperceptible, realiza un hechizo para encender tu varita",
    "hechizo",
    "7A",
    "¡Buen trabajo! Continúa con tu búsqueda",
    "Te maravillas por los grandes árboles que vas pasando",
    "La tenue brisa del viento de llena de determinación para continuar tu camino",
    "Sin dudar y con paso firme sigues el sonido de un río",
    "La tenue luz de tu varita le de un ambiente más tenebroso",
    "Encuentras el pequeño hilo del rio y decides seguirlo",
    "Tu objetivo se acerca paso a paso, puedes sentirlo",
    "A la distancia una gran rama cae con un sonido seco",
    "Corres hacia esa direccion esperando ver quien fue el causante",
    "Observando a tu alrededor no encuentras nada sospechoso entre las sombras ",
    "Tu camino continua y vez que tienes que pasar cruzar el rio",
    "¡Rápido! Utiliza tu varita para mover algunos troncos",
    "hechizo",
    "0",
    "Con pocas dificultades logras cruzar el río",
    "Detrás empiezas a dejar la parte más oscura del bosque",
    "En ese momento observas una sombra acercarse rápidamente",
    "Utiliza tu varita para asustar a la sombra",
    "hechizo",
    "0A",
    "Aquella sombra siniestra corre hacia otra dirección",
    "Tu camino vuelve a ser iluminado nuevamente por los tenues rayos del sol",
    "El objetivo que te propusiste está cerca de llenarse",
    "Sales del bosque encantado a una luz cegadora"
  ];
  int listSize = 0;
  int index = 0;
  int score = 0;
  String casa;

  @override
  Stream<AdventureState> mapEventToState(
    AdventureEvent event,
  ) async* {
    if (event is StartEvent) {
      casa = event.casa;
      index = 0;
      listSize = list.length;
      yield AdventureStartState(text: list[index], score: score);
    } else if (event is NextEvent) {
      index++;
      if (index < listSize) {
        if (list[index] == "hechizo") {
          index++;
          if (list[index] == '7')
            yield AdventureGestureState(
                text: list[index],
                score: score,
                endX: 53, //53 for range between -50 and 50
                endY: 150,
                specialX: 150,
                specialY: -13); //-13 for nothing
          //This is going to be the min values the special is for the "on pan update" for it to be complex shapes
          else if (list[index] == '7A')
            yield AdventureGestureState(
                text: list[index],
                score: score,
                endX: 53, //53 for range between -50 and 50
                endY: 150,
                specialX: -150,
                specialY: -13);
          else if (list[index] == '0')
            yield AdventureGestureState(
                text: list[index],
                score: score,
                endX: 53, //53 for range between -50 and 50
                endY: 53,
                specialX: -75,
                specialY: 200);
          else if (list[index] == '0A')
            yield AdventureGestureState(
                text: list[index],
                score: score,
                endX: 53, //53 for range between -50 and 50
                endY: 53,
                specialX: 75,
                specialY: 200);
          else
            yield AdventureGestureState(
                text: list[index],
                score: score,
                endX: 0,
                endY: 0,
                specialX: 0,
                specialY: 0);
        } else
          yield AdventureNextState(text: list[index], score: score);
      } else {
        await _updateScore(casa);
        yield AdventureEndState(casa: casa, score: score);
      }
    } else if (event is GestureEvent) {
      index++;
      score += event.score;
      yield AdventureNextState(text: list[index], score: score);
    } else if (event is EndEvent) {
      await _updateScore(casa);
      yield AdventureEndState(casa: casa, score: score);
    }
  }

  Future<void> _updateScore(String inicial) async {
    try {
      var puntos = await FirebaseFirestore.instance
          .collection('casas')
          .get()
          .then((value) => value.docs);
      await FirebaseFirestore.instance
          .collection('casas')
          .doc('3GAIseZjA3cUFxj68lXT')
          .update({"$inicial": puntos.first.data()[inicial] + score});
    } catch (e) {
      throw e;
    }
  }
}
