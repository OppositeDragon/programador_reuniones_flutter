import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final loginProvider = ChangeNotifierProvider<LoginController>((ref) => LoginController());

/// Clase que controla el login de usuarios
class LoginController with ChangeNotifier {
  /// Indica si la aplicacion esta intentado establecer una conexion con Firebase y autenticar el usuario
  bool _isLoading = false;

  /// Indica si se debe mostror la clave del usuario
  bool _showPassword = false;

  /// Indica que usuario esta autenticado, [null] si no hay usuario autenticado
  User? _user;

  /// Obtiene el usuario autenticado
  User? get user => _user;

  /// Obtiene el estado de la conexion con Firebase, [returns] [bool]
  bool get isLoading => _isLoading;

  /// Obtiene el estado de visibilidad de la clave del usuario
  bool get showPassword => _showPassword;

  /// Establece el usuario atenticado, guardandolo en la variable [_user]
  setUser() async {
    _user = await FirebaseAuth.instance.authStateChanges().first;
    notifyListeners();
  }

  ///Establece el estado de la conexion con Firebase, guardandolo en la variable [_isLoading]
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// Establece el estado de visibilidad de la clave del usuario, guardandolo en la variable [_showPassword]
  set showPassword(bool showPassword) {
    _showPassword = showPassword;
    notifyListeners();
  }

  /// Permite crear con [email] y [password], ademas [returns] [UserCredential] envuelto en [Future].
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
    notifyListeners();
    return authResult;
  }

  /// Permite iniciar sesion con [email] y [password], ademas [returns] [UserCredential] envuelto en [Future].
  /// Throws [FirebaseAuthException] si existe algun problema con el inicio de sesion.
  Future<UserCredential?> loginEmailPassword(String email, String password) async {
    try {
      final authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return authResult;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } finally {
      notifyListeners();
    }
    return null;
  }

  /// Permite iniciar sesion con [GoogleAuthProvider],
  /// llama [signInWithPopup] si la plataforma es [kIsWeb] o [GoogleSignIn] a en plataformas moviles.
  Future<void> loginGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
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
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    notifyListeners();
  }

  /// Permite iniciar sesion con [FacebookAuthProvider],
  Future<void> loginFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    notifyListeners();
  }

  /// Permite cerrar sesion llamando a [FirebaseAuth.instance.signOut]
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
