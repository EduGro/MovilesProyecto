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
    "the",
    "computer",
    "wouldn't",
    "start",
    "she",
    "banged",
    "on",
    "the",
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
    "dropped",
    "it",
    "to",
    "the",
    "table",
    "still",
    "nothing",
    "she",
    "banged",
    "her",
    "closed",
    "fist",
    "against",
    "the",
    "top",
    "it",
    "was",
    "at",
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

  @override
  Stream<AdventureState> mapEventToState(
    AdventureEvent event,
  ) async* {
    if (event is StartEvent) {
      index = 0;
      listSize = list.length;
      yield AdventureStartState(text: list[index]);
    } else if (event is NextEvent) {
      index++;
      if (index < listSize)
        yield AdventureNextState(text: list[index]);
      else
        yield AdventureEndState();
    } else if (event is EndEvent) {
      yield AdventureEndState();
    }
  }
}
