import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserController>((ref) {
  return UserController();
});

class UserController with ChangeNotifier {
  Future<void> putUserData(UserCredential authResult, String email, String usuario, String telefono, String nombre,String apellido) async {
    FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
      'email': email,
      'usuario': usuario,
      'telefono': telefono,
      'nombre': nombre,
      'apellido': apellido,
    });
  }
}
