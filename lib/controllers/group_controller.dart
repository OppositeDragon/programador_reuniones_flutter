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
}
