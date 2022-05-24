// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLogin = true;

  String _usuario = '';

  String _clave = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            padding: const EdgeInsets.all(24),
            //	color: Colors.yellow,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              //color: Colors.grey.shade200
            ),
            constraints: const BoxConstraints(maxWidth: 500),
            duration: const Duration(milliseconds: 2000),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 32),
                    Text(
                      isLogin ? 'Iniciar Sesion' : 'Crear cuenta',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Correo electronico", border: OutlineInputBorder()),
                      onSaved: (value) {
                        _usuario = value!.trim();
                      },
                    ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Usuario", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Telefono", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Nombre", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Apellido", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    const SizedBox(height: 24),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Clave", border: OutlineInputBorder()),
                      onSaved: (value) {
                        _clave = value!.trim();
                      },
                    ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Repetir clave", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        if (isLogin) {
                          await ref.read(loginProvider).loginEmailPassword('aa@aa.com', '123456');
                        } else {
                          final UserCredential authResult = await ref.read(loginProvider).createEmailPassword('email@email.com', 'password');
                          await ref.read(userProvider).putUserData(authResult, 'email','usuario', 'telefono', 'nombre', 'apellido');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(isLogin ? 'Iniciar sesion' : 'Crear cuenta'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: RichText(
                        text: isLogin
                            ? const TextSpan(
                                text: 'No tiene cuenta? ',
                                children: [
                                  TextSpan(text: 'Cree una', style: TextStyle(decoration: TextDecoration.underline)),
                                ],
                              )
                            : const TextSpan(
                                text: 'Ya tiene cuenta? ',
                                children: [
                                  TextSpan(text: 'Inicie sesion', style: TextStyle(decoration: TextDecoration.underline)),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (isLogin) const Divider(),
                    if (isLogin) const SizedBox(height: 8),
                    if (isLogin)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(66, 134, 245, 1)),
                        onPressed: () async {
                          await ref.read(loginProvider).loginGoogle();
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              height: 56,
                              width: 56,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(12),
                              child: Image.asset('assets/search.png'),
                            ),
                            const Expanded(
                              child: Text('Continuar con Google', textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    if (isLogin) const SizedBox(height: 16),
                    if (isLogin)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: const Color.fromRGBO(71, 89, 147, 1)),
                        onPressed: () async {
                          await ref.read(loginProvider).loginFacebook();
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              height: 56,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(12),
                              child: Image.asset('assets/facebook.png'),
                            ),
                            const Expanded(
                              child: Text('Continuar con Facebook', textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
