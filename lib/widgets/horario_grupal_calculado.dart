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
	 GroupModel group =GroupModel.empty(); 
  @override
  void initState() {
    super.initState();
		group = ref.read(groupProvider).groupData;
    ref.read(timetableProvider).getTimetablesOfGroup(group.integrantes);
  }

  @override
  Widget build(BuildContext context) {
    final horariosDeGrupos = ref.watch(timetableProvider).horariosDeGrupo;
    final a = ref.read(timetableProvider).horarioGrupalCalculado(horariosDeGrupos);
    return Card(
      elevation: 6,
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: ListView.builder(
          itemCount: a.length,
          itemBuilder: (context, index) {
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
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${entry.key} - ${entry.value}"),
                        ),
                      ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
