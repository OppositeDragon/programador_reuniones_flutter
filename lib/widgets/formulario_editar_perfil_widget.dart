import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';

class FormularioEditarPerfilWidget extends ConsumerStatefulWidget {
  const FormularioEditarPerfilWidget(this.userData, this.switchIsEditingState, {super.key});
  final void Function()? switchIsEditingState;
  final Map<String, dynamic> userData;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormularioEditarPerfilWidgetState();
}

class _FormularioEditarPerfilWidgetState extends ConsumerState<FormularioEditarPerfilWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _user = '';
  String _phone = '';
  String _name = '';
  String _lastName = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Editar datos',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 20),
          /*user */ TextFormField(
            initialValue: widget.userData['usuario'].toString(),
            key: const ValueKey('Nombreusuario'),
            decoration: const InputDecoration(labelText: "Nombre de usuario", border: OutlineInputBorder()),
            validator: (value) {
              if (value!.isEmpty || value.length < 4) {
                return 'Debe tener al menos 4 caracteres';
              }
              return null;
            },
            onSaved: (value) {
              _user = value!.trim();
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  initialValue: widget.userData['nombre'].toString(),
                  key: const ValueKey('name'),
                  decoration: const InputDecoration(labelText: "Nombre", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 2) {
                      return 'Debe tener al menos 2 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!.trim();
                  },
                ),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: /*lastName*/ TextFormField(
                  initialValue: widget.userData['apellido'].toString(),
                  key: const ValueKey('lastName'),
                  decoration: const InputDecoration(labelText: "Apellido", border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 2) {
                      return 'Debe tener al menos 2 caracteres';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _lastName = value!.trim();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          /*phone */ TextFormField(
            initialValue: widget.userData['telefono'].toString(),
            key: const ValueKey('phone'),
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: "Numero de telefono", border: OutlineInputBorder()),
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Debe tener al menos 6 numeros';
              }
              return null;
            },
            onSaved: (value) {
              _phone = value!.trim();
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: widget.switchIsEditingState,
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: _trySubmit,
                child: const Text('Guardar cambios'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _trySubmit() async {
    final bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      await ref.read(userProvider).editUserData(_user, _phone, _name, _lastName);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Datos guardados'),
          ),
        );
      }
      await ref.read(userProvider).getUserData();
      widget.switchIsEditingState!();
    }
  }
}
