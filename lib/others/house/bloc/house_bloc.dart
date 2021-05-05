import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'house_event.dart';
part 'house_state.dart';

class HouseBloc extends Bloc<HouseEvent, HouseState> {
  List<Map<String, dynamic>> topicsList = [];

  HouseBloc() : super(HouseInitial());

  @override
  Stream<HouseState> mapEventToState(
    HouseEvent event,
  ) async* {
    if (event is TopicsEvent) {
      await _getTopics(event.casa);
      yield TopicsState(topicsList: topicsList);
    } else if (event is AddTopicEvent) {
      try {
        await FirebaseFirestore.instance.collection('forums').add({
          "casa": event.casa[0],
          "title": event.title,
          "description": event.desc,
          "respuestas": [],
        });
      } catch (e) {
        throw e;
      }
      await _getTopics(event.casa);
      yield TopicsState(topicsList: topicsList);
    } else if (event is SearchEvent) {
      await _searchTopics(event.keyword, event.casa);
      yield TopicsState(topicsList: topicsList);
    }
  }

  void _getTopics(String casa) async {
    topicsList = [];
    List<QueryDocumentSnapshot> documentList;
    documentList = await FirebaseFirestore.instance
        .collection('forums')
        .where('casa', isEqualTo: casa)
        .get()
        .then((value) => value.docs);

    for (var i in documentList) {
      topicsList.add({
        "title": i.data()['title'],
        "description": i.data()['description'],
        "respuestas": i.data()['respuestas'],
        "id": i.id
      });
    }
  }

  void _searchTopics(String keyword, String casa) async {
    topicsList = [];
    List<QueryDocumentSnapshot> documentList1 = await FirebaseFirestore.instance
        .collection('forums')
        .where('casa', isEqualTo: casa)
        .orderBy('title')
        .where('title', isGreaterThanOrEqualTo: keyword.toLowerCase())
        .where('title', isLessThan: keyword.toLowerCase() + '\uf8ff')
        .get()
        .then((value) => value.docs);

    String new1 =
        keyword[0].toUpperCase() + keyword.substring(1, keyword.length);
    List<QueryDocumentSnapshot> documentList2 = await FirebaseFirestore.instance
        .collection('forums')
        .where('casa', isEqualTo: casa)
        .orderBy('title')
        .where('title', isGreaterThanOrEqualTo: new1)
        .where('title', isLessThan: new1 + '\uf8ff')
        .get()
        .then((value) => value.docs);

    for (var i in documentList1) {
      topicsList.add({
        "title": i.data()['title'],
        "description": i.data()['description'],
        "respuestas": i.data()['respuestas'],
        "id": i.id
      });
    }

    for (var i in documentList2) {
      topicsList.add({
        "title": i.data()['title'],
        "description": i.data()['description'],
        "respuestas": i.data()['respuestas'],
        "id": i.id
      });
    }
  }
}
