import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/models/user_model.dart';

final groupProvider = ChangeNotifierProvider<GroupController>((ref) {
  return GroupController();
});

class GroupController with ChangeNotifier {
  List<UserModel> _listaUsuarios = [];
  List<UserModel> get listaUsuarios => _listaUsuarios;
  Future<void> createGroup(String nombre, String descripcion, List<UserModel> integrantes) async {
    Set<String> members = {};
    members.add(FirebaseAuth.instance.currentUser!.uid);
    for (var element in integrantes) {
      members.add(element.userId);
    }
    final DocumentReference<Map<String, dynamic>> docRef = await FirebaseFirestore.instance.collection("groups").add({
      'nombre': nombre,
      'descripcion': descripcion,
      'admin': FirebaseAuth.instance.currentUser!.uid,
      'integrantes': members,
    });
    //print(docRef.toString());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsersByUser(String value) async {
    final usersRef = await FirebaseFirestore.instance
        .collection("users")
        .where("usuario", isGreaterThanOrEqualTo: value)
        .where("usuario", isLessThanOrEqualTo: '$value\uf8ff')
        .get();

    return usersRef;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsersByEmail(String value) async {
    final usersRef = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isGreaterThanOrEqualTo: value)
        .where("email", isLessThanOrEqualTo: '$value\uf8ff')
        .get();
    return usersRef;
  }

  Future<void> getUsers(String value) async {
    Set<UserModel> setUsuarios = {};
    final usersByUser = await getUsersByUser(value);
    final usersByEmail = await getUsersByEmail(value);
    for (var element in usersByUser.docs) {
      final user = element.data();
      setUsuarios.add(UserModel(
        element.id,
        user['email'],
        user['usuario'],
        user['telefono'],
        user['nombre'],
        user['apellido'],
      ));
    }
    for (var element in usersByEmail.docs) {
      final user = element.data();
      setUsuarios.add(UserModel(
        element.id,
        user['email'],
        user['usuario'],
        user['telefono'],
        user['nombre'],
        user['apellido'],
      ));
    }
    _listaUsuarios = setUsuarios.toList();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGrupos() {
    final grupos =
        FirebaseFirestore.instance.collection("groups").where('integrantes', arrayContains: FirebaseAuth.instance.currentUser!.uid).snapshots();
    // .listen(
    //       (event) => event.docs.forEach((element) { print(element.data()); }),
    //       onError: (error) => print("Listen failed: $error"),
    //     );
    return grupos;
  }
}
