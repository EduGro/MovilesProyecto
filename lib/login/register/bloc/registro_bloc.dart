import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  final _collFirestore = FirebaseFirestore.instance;
  File _profilePic;

  RegistroBloc() : super(RegistroInitial());

  @override
  Stream<RegistroState> mapEventToState(
    RegistroEvent event,
  ) async* {
    if (event is PickImageEvent) {
      _profilePic = await _getImage();
      yield PickedImageState(image: _profilePic);
    } else if (event is RegistroNormalEvent) {
      String imageUrl = await _uploadFile();

      if (imageUrl != null) {
        //yield LoadingState();
        await _saveUser(event.name, event.email, event.pass, event.casa[0],
            event.patronus, event.varita, imageUrl);
        //yield UsuarioRegistradoState();
      } else {
        yield RegistroErrorState(errorMsg: "No se pudo guardar la imagen");
      }
    } else if (event is RegistroGoogleEvent) {}
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
      'varita': varita
    };
    try {
      await _collFirestore.collection("users").add(user);
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
