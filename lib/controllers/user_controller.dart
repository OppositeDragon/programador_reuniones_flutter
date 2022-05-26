import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserController>((ref) {
  return UserController();
});

class UserController with ChangeNotifier {
  Map<String, dynamic>? _userData;
  Map<String, dynamic>? get userData => _userData;

  Future<void> putUserData(UserCredential authResult, String email, String usuario, String telefono, String nombre, String apellido) async {
    FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
      'email': email,
      'usuario': usuario,
      'telefono': telefono,
      'nombre': nombre,
      'apellido': apellido,
    });
  }

  Future<void> getUserData() async {
    if (FirebaseAuth.instance.currentUser == null) {
      print('user is null');
    } else {
      switch (FirebaseAuth.instance.currentUser?.providerData.first.providerId) {
        case 'facebook.com':
        //  final facebookData = await FacebookAuth.instance.getUserData();
          final userInfo = FirebaseAuth.instance.currentUser?.providerData.first;
          Map<String, dynamic> userInfoMap = {
            'email': userInfo?.email,
            'nombre': userInfo?.displayName,
            'apellido': '',
            //'photoURL': facebookData["picture"]["url"],
            'telefono': userInfo?.phoneNumber,
            'usuario': userInfo?.email?.substring(0, userInfo.email?.indexOf('@')),
						'provider':'facebook'
          };
          _userData = userInfoMap;
					break;
        case 'google.com':
          final userInfo = FirebaseAuth.instance.currentUser?.providerData.first;
          Map<String, dynamic> userInfoMap = {
            'email': userInfo?.email,
            'nombre': userInfo?.displayName,
            'apellido': '',
            'photoURL': userInfo?.photoURL,
            'telefono': userInfo?.phoneNumber,
            'usuario': userInfo?.email?.substring(0, userInfo.email?.indexOf('@')),'provider':'google'
          };
          _userData = userInfoMap;
          break;
        case 'password':
          final uid = FirebaseAuth.instance.currentUser!.uid;
          final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
          _userData = snapshot.data() as Map<String, dynamic>;
					_userData!['provider'] = 'password';
          break;
        default:
      }

      print(_userData);
    }
    notifyListeners();
  }
}
