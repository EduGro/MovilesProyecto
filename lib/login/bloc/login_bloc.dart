import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String googleEmail;

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    await GoogleSignIn(scopes: <String>["email"]).signOut();
    if (event is EntrarEvent) {
      String cont = await _searchDB(event.email, event.pass);
      if (event.pass == cont) {
        yield EntrarSuccessState(email: event.email);
      }
    } else if (event is LoginGoogleEvent) {
      bool googleIsReg = await _googleLogin();
      if (googleIsReg) {
        yield EntrarSuccessState(email: googleEmail);
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

  Future<bool> _googleLogin() async {
    final googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();
    await googleUser.authentication;

    googleEmail = googleUser.email;

    List<QueryDocumentSnapshot> documentList;
    documentList = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: googleUser.email)
        .get()
        .then((value) => value.docs);

    if (documentList.length == 1) {
      return true;
    } else {
      return false;
    }
  }
}
