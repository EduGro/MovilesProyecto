import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'leaderboard_event.dart';
part 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  LeaderboardBloc() : super(LeaderboardInitial());
  final _cFirestore = FirebaseFirestore.instance;

  @override
  Stream<LeaderboardState> mapEventToState(
    LeaderboardEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  Future<List> getHouse() async {
    try {
      List leaderboardsTempList = [];
      List leaderboardsList = [];
      int i;
      var house = ['Gryffindor', "Hufflepuff", "Ravenclaw", "Slytherin"];
      int highest = 0;
      var highestHouse;
      var leaderboards = await _cFirestore.collection('casas').get();
      leaderboards.docs.map((e) => leaderboardsTempList.add(e)).toList();
      for (i = 0; i < 4; i++) {
        var temp = house[i].toString().substring(0, 1);
        leaderboardsList.add(leaderboardsTempList[0][temp]);
        if (highest < leaderboardsTempList[0][temp]) {
          highest = leaderboardsTempList[0][temp];
          highestHouse = house[i];
        }
      }

      if (highest < 100) {
        highest += 10;
      } else if (highest < 1000) {
        highest += 100;
      } else {
        highest += 1000;
      }
      leaderboardsList.add(highest);
      leaderboardsList.add(highestHouse);

      return leaderboardsList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
