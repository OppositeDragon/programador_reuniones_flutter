import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';
import 'package:programador_reuniones_flutter/theme/theme_controller.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    ref.read(userProvider).getUserData();
  }

  bool _isEditing = false;
  String _email = '';
  String _user = '';
  String _phone = '';
  String _name = '';
  String _lastName = '';
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider).userData;
    final Color iconColor = Theme.of(context).colorScheme.inversePrimary;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Perfil'),
            actions: [
              IconButton(
                onPressed: () => ref.read(themeProvider).setTheme(),
                icon: const Icon(Icons.settings),
              ),
            ],
            elevation: 1),
        body: Center(
          child: userData == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: !_isEditing
                                ? Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset(
                                            'assets/avatar.png',
                                            height: 150,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.abc, color: iconColor),
                                              const SizedBox(width: 12),
                                              Text(
                                                  userData['usuario']
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.email,
                                                  color: iconColor),
                                              const SizedBox(width: 12),
                                              Text(userData['email'].toString(),
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.person,
                                                  color: iconColor),
                                              const SizedBox(width: 12),
                                              Text(
                                                  "${userData['nombre'].toString()} ${userData['apellido'].toString()}",
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.phone_android,
                                                  color: iconColor),
                                              const SizedBox(width: 12),
                                              Text(
                                                  userData['telefono']
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        updateDataButton(),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      /*user */ TextFormField(
                                        initialValue:
                                            userData['usuario'].toString(),
                                        key:
                                            const ValueKey('Nombre de usuario'),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 4) {
                                            return 'Debe tener al menos 4 caracteres';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "Nombre de usuario",
                                            border: OutlineInputBorder()),
                                        onSaved: (value) {
                                          _user = value!.trim();
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      /*email */ TextFormField(
                                        initialValue:
                                            userData['email'].toString(),
                                        key: const ValueKey('email'),
                                        decoration: const InputDecoration(
                                            labelText: 'Email',
                                            border: OutlineInputBorder()),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.contains('@') ||
                                              value.length < 5) {
                                            return 'Debe ingresar un correo electronico valido.';
                                          }
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (value) {
                                          _email = value!.trim();
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              initialValue:
                                                  userData['nombre'].toString(),
                                              key: const ValueKey('name'),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value.length < 2) {
                                                  return 'Debe tener al menos 2 caracteres';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: "Nombre",
                                                  border: OutlineInputBorder()),
                                              onSaved: (value) {
                                                _name = value!.trim();
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Flexible(
                                            child: /*lastName*/ TextFormField(
                                              initialValue: userData['apellido']
                                                  .toString(),
                                              key: const ValueKey('lastName'),
                                              validator: (value) {
                                                if (value!.isEmpty ||
                                                    value.length < 2) {
                                                  return 'Debe tener al menos 2 caracteres';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: "Apellido",
                                                  border: OutlineInputBorder()),
                                              onSaved: (value) {
                                                _lastName = value!.trim();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      /*phone */ TextFormField(
                                        initialValue:
                                            userData['telefono'].toString(),
                                        key: const ValueKey('phone'),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return 'Debe tener al menos 6 numeros';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: "Numero de telefono",
                                            border: OutlineInputBorder()),
                                        onSaved: (value) {
                                          _phone = value!.trim();
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      updateDataButton(),
                                    ],
                                  ),
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

  ElevatedButton updateDataButton() {
    return ElevatedButton(
      onPressed: () {
        _isEditing ? _updateData() : switchIsEditingState();
      },
      child: Text(_isEditing ? "Actualizar datos" : 'Editar datos'),
    );
  }

  void switchIsEditingState() {
    return setState(() {
      _isEditing = !_isEditing;
    });
  }

  _updateData() {
    switchIsEditingState();
  }
}
