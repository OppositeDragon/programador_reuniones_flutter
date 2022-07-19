import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/models/grupo_model.dart';

class HorasTrabajoWidget extends ConsumerStatefulWidget {
  const HorasTrabajoWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorasTrabajoWidgetState();
}

class _HorasTrabajoWidgetState extends ConsumerState<HorasTrabajoWidget> {
  @override
  Widget build(BuildContext context) {
    final grupos = ref.watch(getGruposProvider);
    return grupos.when(
      data: (data) {
        return ListView.builder(
          itemBuilder: (context, index) {
            print('data ${data.docs[index].data()}');
            final grupo = GroupModel.fromMap(data.docs[index].data());
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(spreadRadius: -1, blurRadius: 3)]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          grupo.nombre,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: grupo.reunionTime != null
                            ? Text(
                                grupo.reunionTime!,
                                style: const TextStyle(fontSize: 17),
                                textAlign: TextAlign.center,
                              )
                            : const Chip(
                                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                                label: Text('El administrador del grupo, aun no selecciona un tiempo de reunion'),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: data.docs.length,
        );
      },
      error: (e, st) {
        return Column(
          children: [
            Text('ERROR: $e'),
            Text('STACKTRACE: $st'),
          ],
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
