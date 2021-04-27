import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    //await GoogleSignIn(scopes: <String>["email"]).singOut();
    if (event is EntrarEvent) {
      String cont = await _searchDB(event.email, event.pass);
      if (event.pass == cont) {
        yield EntrarSuccessState();
      }
    }
  }

  Future<String> _searchDB(String email, String pass) async {
    List<QueryDocumentSnapshot> documentList;
    documentList = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .limit(1)
        .get()
        .then((value) => value.docs);

    String pass;
    if (documentList.length > 1 || documentList.length < 0) {
      pass = null;
    } else {
      pass = documentList.first.get("password");
    }
    return pass;
  }
}
