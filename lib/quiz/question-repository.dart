import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsRepository {
  List _questionList;

  Future<List> getQuestions() async {
    final firestoreInstance = FirebaseFirestore.instance;

    try {
      var data = await firestoreInstance.collection("preguntas").get();
      _questionList = data.docs.toList();
      return _questionList;
    } catch (e) {
      throw e;
    }
  }
}
