import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  final _collFirestore = FirebaseFirestore.instance;
  File _profilePic;
  String googleName = '';
  String googleEmail = '';
  String googleImage = null;

  RegistroBloc() : super(RegistroInitial());

  @override
  Stream<RegistroState> mapEventToState(
    RegistroEvent event,
  ) async* {
    if (event is PickImageEvent) {
      _profilePic = await _getImage();
      yield PickedImageState(image: _profilePic);
    } else if (event is RegistroNormalEvent) {
      bool yaExiste = await _searchDB(event.email);

      if (!yaExiste) {
        String imageUrl = await _uploadFile();
        if (imageUrl != null) {
          await _saveUser(event.name, event.email, event.pass, event.casa,
              event.patronus, event.varita, imageUrl);
          yield UsuarioRegistradoState(email: event.email);
        } else {
          yield RegistroErrorState(errorMsg: "No se pudo guardar la imagen");
        }
      } else {
        yield YaExisteState();
        yield RegistroInitial();
      }
    } else if (event is RegistroGoogleEvent) {
      await _googleRegistro();

      bool yaExiste = await _searchDB(googleEmail);

      if (!yaExiste) {
        yield RegistroGoogleState(name: googleName, image: googleImage);
      } else {
        await GoogleSignIn(scopes: <String>["email"]).signOut();
        yield YaExisteState();
        yield RegistroInitial();
      }
    } else if (event is RegistroFinalGoogleEvent) {
      await _saveUser(googleName, googleEmail, null, event.casa, event.patronus,
          event.varita, googleImage);
      yield UsuarioRegistradoState(email: googleEmail);
    }
  }

  Future<File> _getImage() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      print('Foto de perfil no seleccionada');
      return null;
    }
  }

  Future<String> _uploadFile() async {
    try {
      var time = DateTime.now();
      if (_profilePic == null) return null;
      UploadTask task = FirebaseStorage.instance
          .ref("perfil/imagen_${time}.png")
          .putFile(_profilePic);
      await task;
      return await task.storage
          .ref("perfil/imagen_${time}.png")
          .getDownloadURL();
    } on FirebaseException catch (e) {
      print("Error al subir la imagen: $e");
      return null;
    } catch (e) {
      print("Error al subir la imagen: $e");
      return null;
    }
  }

  Future<bool> _saveUser(String name, String email, String pass, String casa,
      String patronus, String varita, String image) async {
    var user = {
      'name': name,
      'email': email,
      'password': pass,
      'image': image,
      'casa': casa,
      'patronus': patronus,
      'varita': varita,
      'amigos': []
    };
    try {
      await _collFirestore.collection("users").add(user);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<void> _googleRegistro() async {
    final googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();
    final googleAuth = await googleUser.authentication;

    print("user: ${googleUser.displayName}");
    googleName = googleUser.displayName;
    print("user: ${googleUser.email}");
    googleEmail = googleUser.email;
    print("user: ${googleUser.photoUrl}");
    googleImage = googleUser.photoUrl;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User user = authResult.user;
    final firebaseAuthToken = await user.getIdToken();
    assert(firebaseAuthToken != null);
    final User currentUser = FirebaseAuth.instance.currentUser;
    assert(user.uid == currentUser.uid);

    print("Firebase user auth token: $firebaseAuthToken");
  }

  Future<bool> _searchDB(String email) async {
    List<QueryDocumentSnapshot> documentList;
    documentList = await FirebaseFirestore.instance
        .collection('users')
        .where("email", isEqualTo: email)
        .get()
        .then((value) => value.docs);

    if (documentList.length >= 1) {
      return true;
    } else {
      return false;
    }
  }
}
