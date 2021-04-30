import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _cFirestore = FirebaseFirestore.instance;
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  Future<List<itemFriends>> getFirends(name) async {
    try {
      var amigos = await _cFirestore.collection('users').orderBy("name").get();
      print(amigos.size);
      return amigos.docs
          .map(
            (element) => itemFriends(
                name: element["name"], profilePic: element["image"]),
          )
          .toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
