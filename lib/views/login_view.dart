import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/constants/strings.dart';
import 'package:programador_reuniones_flutter/controllers/login_controller.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLogin = true;
  bool _showPassword = false;

  String _password = '';
  String _email = '';
  String _user = '';
  String _phone = '';
  String _name = '';
  String _lastName = '';

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(loginProvider).isLoading;
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Form(
                      key: _formKey,
                      child: Card(
                        elevation: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(height: 32),
                              Text(
                                isLogin
                                    ? Strings.labelIniciarSesion
                                    : Strings.labelCrearCuenta,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(height: 32),
                              if (!isLogin) /*name*/ TextFormField(
                                  key: const ValueKey('name'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 2) {
                                      return Strings.msgNameLastCarac;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: Strings.labelNombre,
                                      border: OutlineInputBorder()),
                                  onSaved: (value) {
                                    _name = value!.trim();
                                  },
                                ),
                              if (!isLogin) const SizedBox(height: 24),
                              if (!isLogin)
                                /*lastName*/ TextFormField(
                                  key: const ValueKey('lastName'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 2) {
                                      return Strings.msgNameLastCarac;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: Strings.labelApellido,
                                      border: OutlineInputBorder()),
                                  onSaved: (value) {
                                    _lastName = value!.trim();
                                  },
                                ),
                              if (!isLogin) const SizedBox(height: 24),
                              if (!isLogin)
                                /*user */ TextFormField(
                                  key: const ValueKey('Nombre de usuario'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return Strings.msgUserName;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: Strings.labelUserName,
                                      border: OutlineInputBorder()),
                                  onSaved: (value) {
                                    _user = value!.trim();
                                  },
                                ),
                              if (!isLogin) const SizedBox(height: 24),
                              if (!isLogin)
                                /*phone */ TextFormField(
                                  key: const ValueKey('phone'),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return Strings.msgPhone;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: Strings.labelPhone,
                                      border: OutlineInputBorder()),
                                  onSaved: (value) {
                                    _phone = value!.trim();
                                  },
                                ),
                              if (!isLogin) const SizedBox(height: 24),
                              /*email */ TextFormField(
                                key: const ValueKey('email'),
                                decoration: const InputDecoration(
                                    labelText: Strings.labelEmail,
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !value.contains('@') ||
                                      value.length < 5) {
                                    return Strings.msgEmail;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  _email = value!.trim();
                                },
                              ),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /**password */ Flexible(
                                    child: TextFormField(
                                      key: const ValueKey('password'),
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 8) {
                                          return Strings.msgPassword;
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: Strings.labelClave,
                                          border: OutlineInputBorder()),
                                      obscureText: !_showPassword,
                                      onChanged: (value) {
                                        _password = value.trim();
                                      },
                                      onSaved: (value) {
                                        _password = value!.trim();
                                      },
                                    ),
                                  ),
                                  if (!isLogin) const SizedBox(width: 24),
                                  if (!isLogin)
                                    /**password2 */ Flexible(
                                      child: TextFormField(
                                        key: const ValueKey('password2'),
                                        validator: (value) {
                                          if (value != _password) {
                                            return Strings.msgPassword2;
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: Strings.labelConfirmarClave,
                                            border: OutlineInputBorder()),
                                        obscureText: !_showPassword,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _showPassword,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _showPassword = value!;
                                      });
                                    },
                                  ),
                                  const Text(Strings.labelMostrarClave),
                                ],
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () async {
                                  await _trySubmit();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(isLogin
                                      ? Strings.labelIniciarSesion
                                      : Strings.labelCrearCuenta),
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(isLogin
                                            ? Strings.labelQuesCuenta1
                                            : Strings.labelQuesCuenta2),
                                        Text(
                                            isLogin
                                                ? Strings.labelOpCuenta1
                                                : Strings.labelOpCuenta2,
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline)),
                                      ])
                                  //  Row(mainAxisSize: MainAxisSize.min,children: [
                                  //     const Text(),
                                  //     const Text(, style: TextStyle(decoration: TextDecoration.underline)),
                                  //   ]),
                                  ),
                              const SizedBox(height: 8),
                              if (isLogin) const Divider(),
                              if (isLogin) const SizedBox(height: 8),
                              if (isLogin)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color.fromRGBO(
                                          66, 134, 245, 1)),
                                  onPressed: () async {
                                    ref.read(loginProvider).isLoading = true;
                                    await ref.read(loginProvider).loginGoogle();
                                    await ref.read(userProvider).getUserData();
                                    Map<String, dynamic>? userData =
                                        ref.read(userProvider).userData;
                                    await ref.read(userProvider).putUserData(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData!['email'],
                                          userData['usuario'].toString(),
                                          userData['telefono'] ?? '',
                                          userData['nombre'],
                                          userData['apellido'],
                                          userData['provider'],
                                        );
                                    ref.read(loginProvider).isLoading = false;
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        height: 56,
                                        width: 56,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        padding: const EdgeInsets.all(12),
                                        child: Image.asset('assets/search.png'),
                                      ),
                                      const Expanded(
                                        child: Text(Strings.labelGoogle,
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                ),
                              if (isLogin) const SizedBox(height: 16),
                              if (isLogin)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          const Color.fromRGBO(71, 89, 147, 1)),
                                  onPressed: () async {
                                    ref.read(loginProvider).isLoading = true;
                                    await ref
                                        .read(loginProvider)
                                        .loginFacebook();
                                    await ref.read(userProvider).getUserData();
                                    Map<String, dynamic>? userData =
                                        ref.read(userProvider).userData;
                                    await ref.read(userProvider).putUserData(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          userData!['email'],
                                          userData['usuario'].toString(),
                                          userData['telefono'] ?? '',
                                          userData['nombre'],
                                          userData['apellido'],
                                          userData['provider'],
                                        );
                                    ref.read(loginProvider).isLoading = false;
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        height: 56,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        padding: const EdgeInsets.all(12),
                                        child:
                                            Image.asset('assets/facebook.png'),
                                      ),
                                      const Expanded(
                                        child: Text(Strings.labelFacebook,
                                            textAlign: TextAlign.center),
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
              ),
      ),
    );
  }

  _trySubmit() async {
    ref.read(loginProvider).isLoading = true;
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      if (isLogin) {
        await ref.read(loginProvider).loginEmailPassword(_email, _password);
      } else {
        final UserCredential authResult = await ref
            .read(loginProvider)
            .createEmailPassword(_email, _password);
        await ref.read(userProvider).putUserData(
              authResult.user!.uid,
              _email,
              _user,
              _phone,
              _name,
              _lastName,
              'password',
            );
      }
    }
    ref.read(loginProvider).isLoading = false;
  }
}
