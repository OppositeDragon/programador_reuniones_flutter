import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:programador_reuniones_flutter/constants/strings.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';

class GruposPersonal extends ConsumerStatefulWidget {
  const GruposPersonal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GruposPersonalState();
}

class _GruposPersonalState extends ConsumerState<GruposPersonal> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 550),
      child: Stack(
        children: [
          StreamBuilder(
            stream: ref.read(groupProvider).getGrupos(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Algo ha salido mal ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data?.docs != null && snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    Strings.msgNoGrupos,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  final grupoData = snapshot.data?.docs[index].data() as Map<String, dynamic>;
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
                                  text: Strings.labelMiembros,
                                  // startAngleAlignment: StartAngleAlignment.end,
                                  placement: Placement.outside,
                                  direction: Direction.clockwise),
                            ),
                          ],
                        )),
                    title: Text('${grupoData['nombre']}'),
                    subtitle: Text('${grupoData['descripcion']}'),
                    onTap: () => context.pushNamed('grupo', params: {'gid': snapshot.data!.docs[index].id}),
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
              onPressed: () => context.pushNamed('nuevo'), //,params:{'id':'nuevo'});              ,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
