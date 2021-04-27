import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'adventure_event.dart';
part 'adventure_state.dart';

class AdventureBloc extends Bloc<AdventureEvent, AdventureState> {
  AdventureBloc() : super(AdventureInitial());
  List<String> list = [
    "¡Oh, no! Estás caminando por el bosque prohibido cuando te encuentras con un troll....",
    "Gato",
    "hechizo",
    "7",
    "computer",
    "wouldn't",
    "start",
    "she",
    "banged",
    "hechizo",
    "7A",
    "side",
    "and",
    "tried",
    "again",
    "nothing",
    "she",
    "lifted",
    "it",
    "up",
    "and",
    "hechizo",
    "0",
    "dropped",
    "it",
    "to",
    "it",
    "hechizo",
    "0A",
    "this",
    "moment",
    "she",
    "saw",
    "the",
    "irony",
    "of",
    "trying",
    "to",
    "fix",
    "the",
    "machine",
    "with",
    "violence"
  ];
  int listSize = 0;
  int index = 0;
  int score = 0;

  @override
  Stream<AdventureState> mapEventToState(
    AdventureEvent event,
  ) async* {
    if (event is StartEvent) {
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
      } else
        yield AdventureEndState();
    } else if (event is GestureEvent) {
      index++;
      score += event.score;
      yield AdventureNextState(text: list[index], score: score);
    } else if (event is EndEvent) {
      yield AdventureEndState();
    }
  }
}
