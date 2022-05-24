import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final loginProvider = ChangeNotifierProvider<LoginController>((ref) {
  return LoginController();
});

class LoginController with ChangeNotifier {
  Future<UserCredential> createEmailPassword(String email, String password) async {
    late UserCredential authResult;
    try {
        authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
      return authResult;
  }

  Future<void> loginEmailPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> loginGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // Once signed in, return the UserCredential
      final a = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      print(a);
    } else {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final a = await FirebaseAuth.instance.signInWithCredential(credential);
      print(a);
    }
  }

  Future<void> loginFacebook() async {
    if (kIsWeb) {
      FacebookAuthProvider facebookProvider = FacebookAuthProvider()
        ..addScope('email')
        ..addScope('public_profile')
        ..setCustomParameters({
          'display': 'popup',
        }); // Once signed in, return the UserCredential
      final a = await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      print(a);
    } else {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final a = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      print(a);
    }
  }
}
