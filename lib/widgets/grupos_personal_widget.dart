import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';

class GruposPersonal extends ConsumerStatefulWidget {
  const GruposPersonal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GruposPersonalState();
}

class _GruposPersonalState extends ConsumerState<GruposPersonal> {
  final List<String> items = List.generate(13, (index) => 'Grupo numero${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: Stack(
          children: [
            StreamBuilder(
              stream: ref.read(groupProvider).getGrupos(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Algo ha salido mal');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final grupoData = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                    //final integrantesData = grupoData['integrantes'] as List<String>;
                    return ListTile(
                      isThreeLine: true,
                      leading: CircleAvatar(
                          radius: 22,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('${grupoData['integrantes'].length}'),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: ArcText(
                                    stretchAngle: 354.7,
                                    startAngle: 4.0,
                                    radius: 11.4,
                                    textStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 9, fontWeight: FontWeight.w800),
                                    text: 'miembros',
                                    // startAngleAlignment: StartAngleAlignment.end,
                                    placement: Placement.outside,
                                    direction: Direction.clockwise),
                              ),
                            ],
                          )),
                      title: Text('${grupoData['nombre']}'),
                      subtitle: Text('${grupoData['descripcion']}'),
                    );
                  },
                );
              },
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  context.pushNamed('nuevoGrupo');
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
