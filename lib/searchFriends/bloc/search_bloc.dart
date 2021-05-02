import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:proyectoMoviles/utils/item_friends.dart';

part 'search_event.dart';
part 'search_state.dart';

// ignore: camel_case_types
class uniqueUser {
  String name;
  String id;
  List<dynamic> amigos;

  uniqueUser({
    this.name,
    this.id,
    this.amigos,
  });
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _cFirestore = FirebaseFirestore.instance;
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

  Future<List<itemFriends>> getFriends(name, amigosArray) async {
    try {
      if (name != '') {
        int i;
        var amigosList = {"a"};
        if (amigosArray != null) {
          for (i = 0; i < amigosArray.length; i++) {
            //substring due to "DocumentReference(users/[thingWeNeed])"
            amigosList.add(
              amigosArray[i].toString().substring(
                    24,
                    (amigosArray[i].toString().length - 1),
                  ),
            );
          }
        }
        var amigos = await _cFirestore
            .collection('users')
            .orderBy("name")
            .where('name',
                isGreaterThanOrEqualTo: name.toString().toUpperCase())
            .where('name',
                isLessThanOrEqualTo: name.toString().toUpperCase() + '\uf8ff')
            .get();
        var list = amigos.docs
            .map(
              (element) => itemFriends(
                  name: element["name"],
                  profilePic: element["image"],
                  id: element.id,
                  casa: element["casa"],
                  isAmigo: amigosList.contains(element.id) ? 0 : 1),
            )
            .toList();
        var amigos2 = await _cFirestore
            .collection('users')
            .orderBy("name")
            .where('name',
                isGreaterThanOrEqualTo: name.toString().toLowerCase())
            .where('name',
                isLessThanOrEqualTo: name.toString().toLowerCase() + '\uf8ff')
            .get();
        var list2 = amigos2.docs
            .map(
              (element) => itemFriends(
                  name: element["name"],
                  profilePic: element["image"],
                  id: element.id,
                  casa: element["casa"],
                  isAmigo: amigosList.contains(element.id.toString()) ? 0 : 1),
            )
            .toList();
        list.addAll(list2.toList());
        return list;
      } else
        return null;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<bool> deleteUser(id, user) async {
    try {
      var unique = await _cFirestore
          .collection('users')
          .where("image", isEqualTo: user['image'])
          .where("email", isEqualTo: user['email'])
          .get();
      var list = unique.docs
          .map(
            (element) => uniqueUser(
              name: element["name"],
              id: element.id,
              amigos: element["amigos"],
            ),
          )
          .toList();
      var toPass = "DocumentReference(users/$id)";
      list[0].amigos.removeWhere((element) => element.toString() == toPass);
      var unique2 = await _cFirestore
          .collection('users')
          .doc(list[0].id)
          .update({'amigos': list[0].amigos});
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<bool> addUser(id, user) async {
    try {
      var unique = await _cFirestore
          .collection('users')
          .where("image", isEqualTo: user['image'])
          .where("email", isEqualTo: user['email'])
          .get();
      var list = unique.docs
          .map(
            (element) => uniqueUser(
              name: element["name"],
              id: element.id,
              amigos: element["amigos"],
            ),
          )
          .toList();
      DocumentReference toPass = await _cFirestore.collection('users').doc(id);
      if (list[0].amigos.contains(toPass)) return true;
      list[0].amigos.add(toPass);
      var unique2 = await _cFirestore
          .collection('users')
          .doc(list[0].id)
          .update({'amigos': list[0].amigos});
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<List<itemFriends>> addedFriends(amigosArray) async {
    try {
      int i;
      List<itemFriends> friendsList = [];
      if (amigosArray != null) {
        for (i = 0; i < amigosArray.length; i++) {
          //substring due to "DocumentReference(users/[thingWeNeed])"
          var temp = amigosArray[i].toString().substring(
                24,
                (amigosArray[i].toString().length - 1),
              );
          print(temp);
          DocumentSnapshot element =
              await _cFirestore.collection('users').doc(temp).get();
          friendsList.add(
            itemFriends(
                name: element["name"],
                profilePic: element["image"],
                id: element.id,
                casa: element["casa"],
                isAmigo: 2),
          );
        }
      }
      return friendsList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
