import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = ChangeNotifierProvider<UserController>((ref) => UserController());

class UserController with ChangeNotifier {
  String _password = '';
  Map<String, dynamic>? _userData;

  String get password => _password;
  Map<String, dynamic>? get userData => _userData;
  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<void> putUserData(
    String userUID,
    String email,
    String usuario,
    String telefono,
    String nombre,
    String apellido,
    String proveedor,
  ) async {
    FirebaseFirestore.instance.collection('users').doc(userUID).set(
      {
        'email': email,
        'usuario': usuario,
        'telefono': telefono,
        'nombre': nombre,
        'apellido': apellido,
        'proveedor': proveedor,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> getUserData() async {
    if (FirebaseAuth.instance.currentUser == null) {
      print('user is null');
    } else {
      switch (FirebaseAuth.instance.currentUser?.providerData.first.providerId) {
        case 'facebook.com':
          Map<String, dynamic>? facebookData = {};
          try {
            facebookData = await FacebookAuth.instance.getUserData();
            print(facebookData);
            print('facebookPhoto ${facebookData == null ? null : facebookData["picture"]["data"]["url"]}');
          } catch (e) {
            facebookData = null;
          }

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
    }
    notifyListeners();
  }

  Future<void> editUserData(String user, String phone, String name, String lastName) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'usuario': user,
      'telefono': phone,
      'nombre': name,
      'apellido': lastName,
    }, SetOptions(merge: true));
  }
}
