import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/models/grupo_model.dart';
import 'package:programador_reuniones_flutter/models/user_model.dart';

final groupProvider = ChangeNotifierProvider<GroupController>((ref) {
  return GroupController();
});
final getGruposProvider = StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref)  {
  final a = ref.watch(groupProvider);
  return  a.getGrupos();
});

class GroupController with ChangeNotifier {
  Set<UserModel> _listaUsuarios = {};
  GroupModel _groupData = GroupModel.empty();
  GroupModel _groupDataTemp = GroupModel.empty();

  Set<UserModel> get listaUsuarios => _listaUsuarios;
  GroupModel get groupData => _groupData;
  GroupModel get groupDataTemp => _groupDataTemp;

  set nombreGrupo(String nombre) => _groupDataTemp.nombre = nombre;
  set descripcionGrupo(String descripcion) => _groupDataTemp.descripcion = descripcion;

  Future<String> createGroup(String nombre, String descripcion, Set<UserModel> integrantes) async {
    Set<String> members = {};
    members.add(FirebaseAuth.instance.currentUser!.uid);
    for (var element in integrantes) {
      members.add(element.userId);
    }
    final document = FirebaseFirestore.instance.collection("groups").doc();

    await document.set({
      'docId': document.id,
      'nombre': nombre,
      'descripcion': descripcion,
      'admin': FirebaseAuth.instance.currentUser!.uid,
      'integrantes': members.toList(),
    }, SetOptions(merge: true));
    return document.id;
  }

  Future<void> updateGroup(String groupId, String nombre, String descripcion, String? reunionTime, Set<UserModel> integrantes) async {
    Set<String> members = {};
    members.add(FirebaseAuth.instance.currentUser!.uid);
    for (var element in integrantes) {
      members.add(element.userId);
    }
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update(<String, dynamic>{'integrantes': FieldValue.delete()});
    await FirebaseFirestore.instance.collection("groups").doc(groupId).set({
      'docId': groupId,
      'nombre': nombre,
      'descripcion': descripcion,
      'admin': FirebaseAuth.instance.currentUser!.uid,
      'integrantes': members.toList(),
      'reunionTime': reunionTime
    });
    // resetGroupData();
    notifyListeners();
  }

  Future<GroupModel> getGroupById(String? groupId) async {
    final docRef = await FirebaseFirestore.instance.collection("groups").doc(groupId).get();
    final groupdata = docRef.data();
    final Set<UserModel> integrantes = await getIntegrantes(groupdata!['integrantes']);
    final groupData = GroupModel(
        docId: groupdata['docId'],
        descripcion: groupdata['descripcion'],
        admin: groupdata['admin'],
        nombre: groupdata['nombre'],
        reunionTime: groupdata['reunionTime'],
        integrantes: integrantes);
    _groupData = groupData;
    _groupDataTemp = groupData.copyWith();
    notifyListeners();
    return _groupData;
  }

  Future<void> getUsers(String value) async {
    Set<UserModel> setUsuarios = {};
    final usersByUser = await getUsersByUser(value);
    final usersByEmail = await getUsersByEmail(value);
    for (final element in usersByUser.docs) {
      final user = element.data();
      setUsuarios.add(UserModel(
        userId: element.id,
        email: user['email'],
        usuario: user['usuario'],
        telefono: user['telefono'],
        nombre: user['nombre'],
        apellido: user['apellido'],
        proveedor: user['proveedor'],
      ));
    }
    for (final element in usersByEmail.docs) {
      final user = element.data();
      setUsuarios.add(UserModel(
        userId: element.id,
        email: user['email'],
        usuario: user['usuario'],
        telefono: user['telefono'],
        nombre: user['nombre'],
        apellido: user['apellido'],
        proveedor: user['proveedor'],
      ));
    }
    _listaUsuarios = setUsuarios;
    notifyListeners();
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getGrupos() {
    final grupos = FirebaseFirestore.instance
        .collection("groups")
        .where(
          'integrantes',
          arrayContains: FirebaseAuth.instance.currentUser!.uid,
        )
        .snapshots();
    return grupos;
  }

  Future<Set<UserModel>> getIntegrantes(List<dynamic> lIntegrantes) async {
    final Set<UserModel> integrantes = {};
    for (String element in lIntegrantes) {
      if (element.isNotEmpty) {
        final integrante = await FirebaseFirestore.instance.collection('users').doc(element).get();
        final user = integrante.data();
        integrantes.add(UserModel(
          userId: integrante.id,
          email: user!['email'],
          usuario: user['usuario'],
          telefono: user['telefono'],
          nombre: user['nombre'],
          apellido: user['apellido'],
          proveedor: user['proveedor'],
        ));
      }
    }
    groupData.integrantes = integrantes;
    notifyListeners();
    return integrantes;
  }

  void addIntegrante(UserModel user) {
    Set<UserModel> integrantes = {};
    integrantes.add(user);
    for (var element in _groupDataTemp.integrantes) {
      integrantes.add(element);
    }
    _groupDataTemp.integrantes = integrantes;
    notifyListeners();
  }

  void removeIntegrate(UserModel integrante) {
    Set<UserModel> integrantes = {};
    for (var element in _groupDataTemp.integrantes) {
      if (element != integrante) integrantes.add(element);
    }
    _groupDataTemp.integrantes = integrantes;
    notifyListeners();
  }

  void resetGroupData() {
    _groupData = GroupModel.empty();
    _groupDataTemp = GroupModel.empty();
  }
}
