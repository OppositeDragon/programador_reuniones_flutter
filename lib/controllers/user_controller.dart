import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';

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
          final facebookData = await FacebookAuth.instance.getUserData();
          final userInfo = FirebaseAuth.instance.currentUser?.providerData.first;
          Map<String, dynamic> userInfoMap = {
            'email': userInfo?.email,
            'nombre': userInfo?.displayName,
            'apellido': '',
            'photoURL': facebookData == null ? null : facebookData["picture"]["data"]["url"],
            'telefono': userInfo?.phoneNumber,
            'usuario': userInfo?.email?.substring(0, userInfo.email?.indexOf('@')),
            'provider': 'facebook'
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
            'usuario': userInfo?.email?.substring(0, userInfo.email?.indexOf('@')),
            'provider': 'google'
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

  editUserEmail(String email, String password) async {
    await FirebaseAuth.instance.currentUser?.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: password));
    await FirebaseAuth.instance.currentUser?.updateEmail(email);
  }
  
	Future<void> editUserData(String email, String user, String phone, String name, String lastName) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'email': email,
      'usuario': user,
      'telefono': phone,
      'nombre': name,
      'apellido': lastName,
    }, SetOptions(merge: true));
  }
String _password = '';
String get password=>_password;


  void setPassword(String value) {_password = value;
		notifyListeners();}
	
}
