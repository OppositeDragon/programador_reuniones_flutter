import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';
import 'package:programador_reuniones_flutter/controllers/timetable_controller.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';
import 'package:programador_reuniones_flutter/models/grupo_model.dart';

class HorarioGrupalCalculado extends ConsumerStatefulWidget {
  const HorarioGrupalCalculado({super.key});

  @override
  ConsumerState<HorarioGrupalCalculado> createState() => _HorarioGrupalCalculadoState();
}

class _HorarioGrupalCalculadoState extends ConsumerState<HorarioGrupalCalculado> {
  GroupModel group = GroupModel.empty();
  @override
  void initState() {
    super.initState();
    group = ref.read(groupProvider).groupData;
    ref.read(timetableProvider).getTimetablesOfGroup(group.integrantes);
  }

  @override
  Widget build(BuildContext context) {
    group = ref.watch(groupProvider.select((value) => value.groupData));
    final horariosDeGrupos = ref.watch(timetableProvider).horariosDeGrupo;
    final a = ref.read(timetableProvider).horarioGrupalCalculado(horariosDeGrupos);
    return Card(
      elevation: 6,
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: group.reunionTime != null
            ? Stack(
                children: [
                  Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiaryContainer, borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                        child: Text(
                          group.reunionTime.toString(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FirebaseAuth.instance.currentUser!.uid != group.admin
                        ? Chip(
                            labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                            label: Text(
                              'El administrador de grupo puede cambiar el tiempo de la reunión',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade600, fontSize: 12),
                            ),
                          )
                        : TextButton(
                            onPressed: () => setState(() => group.reunionTime = null),
                            child: const Text(
                              'RESET',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                  ),
                ],
              )
            : Column(
                children: [
                  if (FirebaseAuth.instance.currentUser!.uid != group.admin)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Chip(
                        labelPadding: EdgeInsets.symmetric(horizontal: 4),
                        label: Text(
                          'El administrador de grupo ha de seleccionar uno de los tiempos diponibles.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey, fontSize: 12),
                        ),
                      ),
                    ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: a.length,
                      itemBuilder: (context, index) {
                        if (a[index].entries.isNotEmpty) {
                          return Column(
                            children: [
                              const SizedBox(height: 12),
                              Text(
                                WeekDays.values[index].diaCompleto,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Column(
                                children: [
                                  for (final entry in a[index].entries)
                                    InkWell(
                                      onTap: FirebaseAuth.instance.currentUser!.uid != group.admin
                                          ? null
                                          : () async {
                                              ref
                                                  .read(timetableProvider)
                                                  .setHorarioCompartido(group.docId, entry, WeekDays.values[index].diaCompleto);
                                              await ref.read(groupProvider).getGroupById(group.docId);
                                            },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${entry.key} - ${entry.value}"),
                                      ),
                                    ),
                                ],
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
