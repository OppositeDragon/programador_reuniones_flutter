import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';

class GroupDetailView extends ConsumerStatefulWidget {
  const GroupDetailView(this.groupId, {super.key});
  final String? groupId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends ConsumerState<GroupDetailView> {
  @override
  void initState() {
    super.initState();
    ref.read(groupProvider).getGroupById(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    final group = ref.watch(groupProvider).groupData;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppBarWidget('Detalles del grupo'),
      floatingActionButton: FirebaseAuth.instance.currentUser!.uid != group.admin
          ? null
          : FloatingActionButton(
              onPressed: () {
                context.goNamed('editar', params: {'gid': widget.groupId!});
              },
              mini: true,
              tooltip: 'Editar grupo',
              child: const Icon(Icons.edit_note),
            ),
      body: Center(
        child: group.docId != widget.groupId
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 550),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Card(
                            elevation: 12,
                            color: Theme.of(context).colorScheme.primaryContainer,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  const CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          group.nombre,
                                          style: textTheme.headline5,
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(group.descripcion)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Horario grupal calculado:',
                          style: textTheme.headline5,
                          textAlign: TextAlign.start,
                        ),
                        Card(
                          elevation: 6,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          child: const SizedBox(
                            width: double.infinity,
                            height: 300,
                          ),
                        ),
                        Text(
                          'Integrantes:',
                          style: textTheme.headline5,
                          textAlign: TextAlign.start,
                        ),
                        Card(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          elevation: 6,
                          child: SizedBox(
                            height: 250,
                            child: ListView.separated(
                              // shrinkWrap: true,
                              itemCount: group.integrantes.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text("${group.integrantes.elementAt(index).nombre} ${group.integrantes.elementAt(index).apellido}"),
                                subtitle: Text(group.integrantes.elementAt(index).email),
                              ),
                              separatorBuilder: (context, index) => const Divider(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
