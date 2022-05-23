import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                    Text(
                      isLogin ? 'Iniciar Sesion' : 'Crear cuenta',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Correo electronico",
                          border: OutlineInputBorder()),
                      onSaved: (value) {
                        _usuario = value!.trim();
                      },
                    ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Usuario", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Telefono",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Nombre", border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Apellido",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    const SizedBox(height: 24),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Clave", border: OutlineInputBorder()),
                      onSaved: (value) {
                        _clave = value!.trim();
                      },
                    ),
                    if (!isLogin) const SizedBox(height: 24),
                    if (!isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Repetir clave",
                            border: OutlineInputBorder()),
                        onSaved: (value) {
                          _clave = value!.trim();
                        },
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => GoRouter.of(context).go('/dashboard'),
                      child: Text(isLogin ? 'Iniciar sesion' : 'Crear cuenta'),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin
                          ? 'No tiene cuenta? Cree una'
                          : 'Ya tiene cuenta? Inicie sesion'),
                    ),
                    const SizedBox(height: 8),
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
