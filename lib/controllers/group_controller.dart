import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupProvider = ChangeNotifierProvider<GroupController>((ref) {
  return GroupController();
});

class GroupController with ChangeNotifier {
  Future<void> createGroup(String nombre, String descripcion, List<String> integrantes) async {
    final DocumentReference<Map<String, dynamic>> docRef = await FirebaseFirestore.instance.collection("groups").add({
      'nombre': nombre,
      'descripcion': descripcion,
      'admin': FirebaseAuth.instance.currentUser!.uid,
      'integrantes': integrantes,
    });
    print(docRef.toString());
  }

  Future<void> getUsers(String user) async {
    final usersRef = await FirebaseFirestore.instance.collection("users")
    .where("usuario", isGreaterThanOrEqualTo: user)
    .where("usuario", isLessThanOrEqualTo: '$user\uf8ff')
    .get();
    // print('usersRef: ${usersRef.docs.length}');
    // for (var element in usersRef.docs) {
    //   print('${element.data()}');
    // }
  }
}
