import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';
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
    getGroupData();
  }

  getGroupData() async {
    final a = await ref.read(groupProvider).getGroupById(widget.groupId);
    await ref.read(userProvider).getIntegrantes(a!['integrantes']);
  }

  @override
  Widget build(BuildContext context) {
    final group = ref.watch(groupProvider).groupData;
    final integrantes = ref.watch(userProvider).integrantes;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppBarWidget('Detalles del grupo'),
      body: Center(
        child: group == null || group['docId'] != widget.groupId
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
                            color: Theme.of(context).colorScheme.primaryVariant,
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
                                          group['nombre'],
                                          style: textTheme.headline5,
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(group['descripcion'])
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
                              itemCount: integrantes.length,
                              itemBuilder: (context, index) => ListTile(
                                title: Text(integrantes[index]!['nombre'] + " " + integrantes[index]!['apellido']),
                                subtitle: Text(integrantes[index]!['email']),
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
