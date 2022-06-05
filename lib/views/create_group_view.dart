import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';

class CreateGroupView extends ConsumerStatefulWidget {
  const CreateGroupView({super.key});

  @override
  ConsumerState<CreateGroupView> createState() => _CreateGroupView();
}

class _CreateGroupView extends ConsumerState<CreateGroupView> {
  final _formKey = GlobalKey<FormState>();
  final List<String> integrantes = [];
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
                      final resultado = await showSearch(context: context, delegate: Busqueda());
                      if (resultado!.isNotEmpty && resultado != "") {
                        setState(() {
                          integrantes.add(resultado);
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
                      key: Key(sugerencia),
                      background: Container(
                        color: const Color.fromARGB(140, 224, 70, 59),
                        alignment: Alignment.topLeft,
                        child: const Icon(Icons.delete),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          integrantes.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$sugerencia eliminado.')));
                      },
                      child: ListTile(
                        leading: const Icon(Icons.tab_unselected_rounded),
                        title: Text(sugerencia),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          ref.read(groupProvider).createGroup(nombre, descripcion, integrantes);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: SizedBox(
                                child: Text('Procesando'),
                              ),
                            ),
                          );
                        }
                      },
                      child: const SizedBox(
                        width: 80,
                        child: Text(
                          "Crear grupo",
                          textAlign: TextAlign.center,
                        ),
                      )),
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
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Busqueda extends SearchDelegate<String> {
  final usuarios = ["Erick", "Josué", "Lenin", "Steven", "Jean"];
  final usuariosRecientes = ["Erick", "Josué"];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, "");
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sugerencias = query.isEmpty
        ? usuariosRecientes
        : usuarios.where((usuario) {
            final usuarioLower = usuario.toLowerCase();
            final queryLower = query.toLowerCase();

            return usuarioLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(sugerencias);
  }

  Widget buildSuggestionsSuccess(List<String> sugerencias) {
    return ListView.builder(
      itemCount: sugerencias.length,
      itemBuilder: (context, index) {
        final sugerencia = sugerencias[index];
        return ListTile(
          leading: const Icon(Icons.tab_unselected_rounded),
          title: Text(sugerencia),
          onTap: () {
            query = sugerencia;
            close(context, query);
          },
        );
      },
    );
  }
}
