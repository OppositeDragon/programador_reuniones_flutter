import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/constants/strings.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/models/user_model.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';
import 'package:programador_reuniones_flutter/widgets/search_listview.dart';

class CreateEditGroupView extends ConsumerStatefulWidget {
  final String? groupId;
  const CreateEditGroupView(this.groupId, {super.key});

  @override
  ConsumerState<CreateEditGroupView> createState() => _CreateGroupView();
}

class _CreateGroupView extends ConsumerState<CreateEditGroupView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(groupProvider).resetGroupData();
    if (widget.groupId != 'nuevo') ref.read(groupProvider).getGroupById(widget.groupId);
  }

  final TextEditingController _nombreTextController = TextEditingController();
  final TextEditingController _descripcionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final grupoDataTemp = ref.watch(groupProvider).groupDataTemp;
    _nombreTextController.value = TextEditingValue(text: grupoDataTemp.nombre);
    _descripcionTextController.value = TextEditingValue(text: grupoDataTemp.descripcion);
    return Scaffold(
      appBar: AppBarWidget(widget.groupId == 'nuevo' ? Strings.labelGrupo : Strings.labelEditarGrupo),
      body: grupoDataTemp.docId != widget.groupId && widget.groupId != 'nuevo'
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: Strings.labelNameGrupo,
                            border: OutlineInputBorder(),
                          ),
                          controller: _nombreTextController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return  Strings.msgNameGrupo;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            ref.read(groupProvider).nombreGrupo = value;
                          },
                          onSaved: (value) {
                            grupoDataTemp.nombre = value!;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText:  Strings.labelDescGrupo,
                            border: OutlineInputBorder(),
                          ),
                          controller: _descripcionTextController,
                          maxLines: 3,
                          autocorrect: true,
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return Strings.msgDescGrupo;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            ref.read(groupProvider).descripcionGrupo = value;
                          },
                          onSaved: (value) {
                            grupoDataTemp.descripcion = value!;
                          },
                        ),
                        const SizedBox(
                          width: 60,
                          height: 50,
                          child: VerticalDivider(width: 2),
                        ),
                        const Text(Strings.labelBuscar),
                        IconButton(
                          onPressed: () async {
                            final UserModel? user = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const SearchListView();
                                });
                            if (user != null) {
                              ref.read(groupProvider).addIntegrante(user);
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: grupoDataTemp.integrantes.length,
                            itemBuilder: (context, index) {
                              final sugerencia = grupoDataTemp.integrantes.elementAt(index);
                              return Dismissible(
                                key: Key(sugerencia.userId),
                                background: Container(
                                  color: const Color.fromARGB(140, 224, 70, 59),
                                  alignment: Alignment.topLeft,
                                  child: const Icon(Icons.delete),
                                ),
                                onDismissed: (direction) {
                                  ref.read(groupProvider).removeIntegrate(sugerencia);
                                  print('integrantesTemp: ${grupoDataTemp.integrantes}');
                                  print('integrantes: ${ref.read(groupProvider).groupData.integrantes}');
                                  // setState(() {
                                  //   grupoDataTemp.integrantes.remove(grupoDataTemp.integrantes.elementAt(index));
                                  // });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${sugerencia.email} eliminado.')));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      (sugerencia.nombre.isEmpty ? '' : sugerencia.nombre[0]) +
                                          (sugerencia.apellido.isEmpty ? '' : sugerencia.apellido[0]),
                                    ),
                                  ),
                                  title: Text('${sugerencia.nombre} ${sugerencia.apellido}'),
                                  subtitle: Text(sugerencia.userAndEmail),
																	trailing: grupoDataTemp.integrantes.elementAt(index).userId == grupoDataTemp.admin
                                    ? const Chip(
                                        labelPadding: EdgeInsets.symmetric(horizontal: 4),
                                        label: Text(' ADMIN ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)))
                                    : null,
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
                                    const SnackBar(content: Text( Strings.labelProcesando), duration: Duration(milliseconds: 1500)),
                                  );
                                  String newGroupId = '';
                                  if (widget.groupId == 'nuevo') {
                                    newGroupId = await ref.read(groupProvider).createGroup(
                                          grupoDataTemp.nombre,
                                          grupoDataTemp.descripcion,
                                          grupoDataTemp.integrantes,
                                        );
                                  } else {
                                    await ref.read(groupProvider).updateGroup(
                                          widget.groupId!,
                                          grupoDataTemp.nombre,
                                          grupoDataTemp.descripcion,
                                          grupoDataTemp.integrantes,
                                        );
                                  }
                                  if (widget.groupId != 'nuevo') {
                                    await ref.read(groupProvider).getGroupById(widget.groupId);
                                  }
                                  if (!mounted) return;
                                  if (widget.groupId == 'nuevo' && newGroupId != '') {
                                    context.goNamed('grupo', params: {'gid': newGroupId});
                                  } else {
                                    context.pop();
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                child: Text(
                                  widget.groupId == 'nuevo' ? Strings.labelGrupo : Strings.labelEditarGrupo,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                child: Text(
                                  Strings.labelCancelar,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}