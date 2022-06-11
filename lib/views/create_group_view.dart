import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/models/user_model.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';
import 'package:programador_reuniones_flutter/widgets/search_listview.dart';

class CreateGroupView extends ConsumerStatefulWidget {
  const CreateGroupView({super.key});

  @override
  ConsumerState<CreateGroupView> createState() => _CreateGroupView();
}

class _CreateGroupView extends ConsumerState<CreateGroupView> {
  final _formKey = GlobalKey<FormState>();
  final List<UserModel> integrantes = [];
  String nombre = '';
  String descripcion = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget('Crear grupo'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Nombre de grupo",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return "Ingrese el nombre del grupo";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nombre = value!;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Descripcion de grupo",
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Ingrese descripcion del grupo (minimo 10 caracteres)";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            descripcion = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                    height: 50,
                    child: VerticalDivider(width: 2),
                  ),
                  const Text('Buscar integrantes: '),
                  IconButton(
                    onPressed: () async {
                      final UserModel? user = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const SearchListView();
                          });
                      if (user != null) {
                        setState(() {
                          integrantes.add(user);
                        });
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: integrantes.length,
                  itemBuilder: (context, index) {
                    final sugerencia = integrantes[index];
                    return Dismissible(
                      key: Key(sugerencia.userId),
                      background: Container(
                        color: const Color.fromARGB(140, 224, 70, 59),
                        alignment: Alignment.topLeft,
                        child: const Icon(Icons.delete),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          integrantes.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${sugerencia.email} eliminado.')));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            (sugerencia.name.isEmpty ? '' : sugerencia.name[0]) + (sugerencia.lastName.isEmpty ? '' : sugerencia.lastName[0]),
                          ),
                        ),
                        title: Text(sugerencia.userAndEmail),
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Procesando'), duration: Duration(milliseconds: 1500)),
                        );
                        await ref.read(groupProvider).createGroup(nombre, descripcion, integrantes);
                        if (!mounted) return;
                        context.pop();
                      }
                    },
                    child: const SizedBox(
                      width: 80,
                      child: Text(
                        "Crear grupo",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const SizedBox(
                      width: 80,
                      child: Text(
                        "Cancelar",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
