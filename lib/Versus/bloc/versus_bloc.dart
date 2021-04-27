import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyectoMoviles/adventure/bloc/adventure_bloc.dart';

part 'versus_event.dart';
part 'versus_state.dart';

class VersusBloc extends Bloc<VersusEvent, VersusState> {
  VersusBloc() : super(VersusInitial());
  List<String> list = ["7", "7A", "0", "0A"];
  int liveAi = 100;
  int liveP = 100;

  @override
  Stream<VersusState> mapEventToState(
    VersusEvent event,
  ) async* {
    if (event is StartEvent) {
      yield VersusStartState(liveAi: liveAi, liveP: liveP);
    } else if (event is DefendEvent) {
      var index = Random().nextInt(4);
      if (list[index] == '7')
        yield VersusPlayerAttackState(
            liveAi: liveAi,
            liveP: liveP,
            endX: 53, //53 for range between -50 and 50
            endY: 150,
            specialX: 150,
            specialY: -13); //-13 for nothing
      //This is going to be the min values the special is for the "on pan update" for it to be complex shapes
      else if (list[index] == '7A')
        yield VersusPlayerAttackState(
            liveAi: liveAi,
            liveP: liveP,
            endX: 53, //53 for range between -50 and 50
            endY: 150,
            specialX: -150,
            specialY: -13);
      else if (list[index] == '0')
        yield VersusPlayerAttackState(
            liveAi: liveAi,
            liveP: liveP,
            endX: 53, //53 for range between -50 and 50
            endY: 53,
            specialX: -75,
            specialY: 200);
      else if (list[index] == '0A')
        yield VersusPlayerAttackState(
            liveAi: liveAi,
            liveP: liveP,
            endX: 53, //53 for range between -50 and 50
            endY: 53,
            specialX: 75,
            specialY: 200);
      else
        yield VersusPlayerAttackState(
            liveAi: liveAi,
            liveP: liveP,
            endX: 0,
            endY: 0,
            specialX: 0,
            specialY: 0);
    } else if (event is AttackEvent) {
      liveAi -= event.liveAi;
      liveP -= event.liveP;
      yield VersusAiAttackState(liveAi: liveAi, liveP: liveP);
    } else if (event is EndEvent) {
      var winner = liveAi > 0 ? false : true;
      yield VersusEndState(winner: winner);
    }
  }
}
