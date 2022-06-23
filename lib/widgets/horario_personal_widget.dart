import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/timetable_controller.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';
import 'package:programador_reuniones_flutter/models/horario_personal_model.dart';
import 'package:programador_reuniones_flutter/painters/horario_painter.dart';

class HorarioPersonalWidget extends ConsumerStatefulWidget {
  const HorarioPersonalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorarioPersonalWidgetState();
}

class _HorarioPersonalWidgetState extends ConsumerState<HorarioPersonalWidget> {
  double height = 970;
  double zoom(bool action) {
    if (height == Zoom.max.height) {
      return action ? Zoom.max.height : Zoom.midHigh.height;
    }
    if (height == Zoom.midHigh.height) {
      return action ? Zoom.max.height : Zoom.midLow.height;
    }
    if (height == Zoom.midLow.height) {
      return action ? Zoom.midHigh.height : Zoom.min.height;
    }
    //if (height == Zoom.min.height) {
    return action ? Zoom.midLow.height : Zoom.min.height;
    //}
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.read(timetableProvider).getTimetable(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo ha salido mal ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data?.data() == null || snapshot.data!.data()!.isEmpty) {
          return Stack(
            children: [
              Center(
                child: Text(
                  'Aun no ha creado un horario personal',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: FloatingActionButton(
                  onPressed: () => ref.read(timetableProvider).createHorarioPersonal(),
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        }

        final horarioSemanal = SemanaHorarioPersonalModel.fromMap(snapshot.data!.data()!);

        return LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      const SizedBox(width: 40),
                      for (int i = 0; i < WeekDays.values.length; i++) Flexible(flex: 2, child: Center(child: Text(WeekDays.values[i].name))),
                      const SizedBox(width: 6),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight - 31,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        primary: false,
                        child: HorarioPersonalPainter(Size(constraints.maxWidth - 10, height), horarioSemanal),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          width: 40,
                          height: 76,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.onBackground,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox.square(
                              //   dimension: 28,
                              //   child:
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => setState(() => height = zoom(true)),
                                child: Icon(
                                  Icons.zoom_in_rounded,
                                  color: Theme.of(context).colorScheme.secondary,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.onBackground,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ),

                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => setState(() => height = zoom(false)),
                                child: Icon(
                                  Icons.zoom_out_rounded,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              // ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class HorarioPersonalPainter extends ConsumerStatefulWidget {
  const HorarioPersonalPainter(this.size, this.horarioSemanal, {super.key});
  final SemanaHorarioPersonalModel horarioSemanal;
  final Size size;
  @override
  ConsumerState<HorarioPersonalPainter> createState() => _HorarioPersonalPainterState();
}

class _HorarioPersonalPainterState extends ConsumerState<HorarioPersonalPainter> {
  GlobalKey<_HorarioPersonalPainterState> gridKey = GlobalKey<_HorarioPersonalPainterState>();
  Map<String, Offset> drag = {};
  Map<String, Offset> update = {};
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPressStart: (details) {
        drag['onLongPressStart'] = details.localPosition;
        HapticFeedback.mediumImpact();
      },
      onLongPressMoveUpdate: (details) {
        update = ref.read(timetableProvider).calculateOffset(
            startDrag: drag['onLongPressStart']!,
            endDrag: details.localPosition,
            size: widget.size,
            finishedDragging: false,
            horarioSemana: widget.horarioSemanal);
        setState(() => drag['onLongPressEnd'] = details.localPosition);
      },
      onLongPressEnd: (details) {
        update = ref.read(timetableProvider).calculateOffset(
              startDrag: drag['onLongPressStart']!,
              endDrag: details.localPosition,
              size: widget.size,
              finishedDragging: true,
              horarioSemana: widget.horarioSemanal,
            );
        drag['onLongPressEnd'] = details.localPosition;
        final horarioSemanalMutado = ref.read(timetableProvider).mutateHorarioSemana(widget.horarioSemanal);
        ref.read(timetableProvider).updateHorarioSemanal(horarioSemanalMutado);
        HapticFeedback.vibrate();
        update = {};
      },
      child: CustomPaint(
        key: gridKey,
        size: widget.size,
        painter: HorarioPainter(
          horarioSemanal: widget.horarioSemanal,
          theme: theme,
          update: update,
        ),
      ),
    );
  }
}
