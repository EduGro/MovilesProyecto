import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'versus_event.dart';
part 'versus_state.dart';

class VersusBloc extends Bloc<VersusEvent, VersusState> {
  VersusBloc() : super(VersusInitial());
  List<String> list = ["7", "7A", "0", "0A"];
  int liveAi = 100;
  int liveP = 100;
  String casa;

  @override
  Stream<VersusState> mapEventToState(
    VersusEvent event,
  ) async* {
    if (event is StartEvent) {
      casa = event.casa;
      yield VersusStartState(liveAi: liveAi, liveP: liveP);
    } else if (event is AttackEvent) {
      var index = Random().nextInt(4);
      if (event.liveP > 0) {
        if (list[index] == '7')
          yield VersusPlayerAttackState(
              liveAi: event.liveAi,
              liveP: event.liveP,
              endX: 53, //53 for range between -50 and 50
              endY: 150,
              specialX: 150,
              specialY: -13,
              texto: list[index]); //-13 for nothing
        //This is going to be the min values the special is for the "on pan update" for it to be complex shapes
        else if (list[index] == '7A')
          yield VersusPlayerAttackState(
              liveAi: event.liveAi,
              liveP: event.liveP,
              endX: 53, //53 for range between -50 and 50
              endY: 150,
              specialX: -150,
              specialY: -13,
              texto: list[index]);
        else if (list[index] == '0')
          yield VersusPlayerAttackState(
              liveAi: event.liveAi,
              liveP: event.liveP,
              endX: 53, //53 for range between -50 and 50
              endY: 53,
              specialX: -75,
              specialY: 200,
              texto: list[index]);
        else if (list[index] == '0A')
          yield VersusPlayerAttackState(
              liveAi: event.liveAi,
              liveP: event.liveP,
              endX: 53, //53 for range between -50 and 50
              endY: 53,
              specialX: 75,
              specialY: 200,
              texto: list[index]);
        else
          yield VersusPlayerAttackState(
              liveAi: event.liveAi,
              liveP: event.liveP,
              endX: 0,
              endY: 0,
              specialX: 0,
              specialY: 0,
              texto: "PropWand");
      } else
        yield VersusEndState(winner: false, casa: casa, score: 0);
    } else if (event is DefendEvent) {
      liveAi = event.liveAi;
      liveP = event.liveP;
      if (liveAi > 0)
        yield VersusAiAttackState(liveAi: liveAi, liveP: liveP);
      else {
        await _updateScore(casa);
        yield VersusEndState(winner: true, casa: casa, score: liveP);
      }
    } else if (event is EndEvent) {
      var winner = liveAi > 0 ? false : true;
      await _updateScore(event.casa);
      yield VersusEndState(winner: winner, casa: casa, score: liveP);
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
          .update({"$inicial": puntos.first.data()[inicial] + liveP});
    } catch (e) {
      throw e;
    }
  }
}
