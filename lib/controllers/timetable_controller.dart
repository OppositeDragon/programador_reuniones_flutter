import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/constants/constants.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';
import 'package:programador_reuniones_flutter/models/horario_personal_model.dart';

final timetableProvider = ChangeNotifierProvider<TimetableController>((ref) {
  return TimetableController();
});

class TimetableController with ChangeNotifier {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getTimetable() {
    return FirebaseFirestore.instance.collection('timetables').doc(FirebaseAuth.instance.currentUser!.uid).snapshots();
  }

  createHorarioPersonal() {
    final horario = SemanaHorarioPersonalModel(
      uid: FirebaseAuth.instance.currentUser!.uid,
      D: DiaHorarioPersonal(weekDay: WeekDays.D, tiempos: Contstants.allTimeslotsFalse),
      L: DiaHorarioPersonal(weekDay: WeekDays.L, tiempos: Contstants.allTimeslotsFalse),
      M: DiaHorarioPersonal(weekDay: WeekDays.M, tiempos: Contstants.allTimeslotsFalse),
      X: DiaHorarioPersonal(weekDay: WeekDays.X, tiempos: Contstants.allTimeslotsFalse),
      J: DiaHorarioPersonal(weekDay: WeekDays.J, tiempos: Contstants.allTimeslotsFalse),
      V: DiaHorarioPersonal(weekDay: WeekDays.V, tiempos: Contstants.allTimeslotsFalse),
      S: DiaHorarioPersonal(weekDay: WeekDays.S, tiempos: Contstants.allTimeslotsFalse),
    );
    FirebaseFirestore.instance.collection("timetables").doc(FirebaseAuth.instance.currentUser!.uid).set(
          horario.toMap(),
        );
  }

  updateHorarioSemanal(SemanaHorarioPersonalModel horarioSemana) {
    FirebaseFirestore.instance.collection("timetables").doc(FirebaseAuth.instance.currentUser!.uid).set(horarioSemana.toMap());
  }

  Offset getStartOffset(double leftMargin, double hOffset, double vOffset, double startDX, double startDY) {
    double hSpace = leftMargin;
    double vSpace = 0;
    int i = 0, j = 0;
    do {
      i++;
      hSpace += hOffset;
    } while (startDX > hSpace);
    do {
      j++;
      vSpace += vOffset;
    } while (startDY > vSpace);

    return Offset(hSpace - hOffset, vSpace - vOffset + 2);
  }

  Offset getEndOffset(double leftMargin, double hOffset, double vOffset, double endDX, double endDY, Size size) {
    double hSpace = leftMargin + hOffset;
    double vSpace = vOffset;
    if (endDX > size.width) {
      hSpace = size.width;
    } else {
      while (endDX > hSpace) {
        hSpace += hOffset;
      }
    }
    if (endDY > size.height - 10) {
      vSpace = size.height - 10;
    } else {
      while (endDY > vSpace) {
        vSpace += vOffset;
      }
    }
    return Offset(hSpace - 1, vSpace);
  }

  Map<String, Offset> calculateOffset({
    required final Offset startDrag,
    required final Offset endDrag,
    required Size size,
    required bool finishedDragging,
  }) {
    Map<String, Offset> update = {};
    final hOffset = (size.width - Contstants.leftMargin) / 7;
    final vOffset = (size.height - Contstants.bottomMargin) / 96;
    double startDX = startDrag.dx;
    double startDY = startDrag.dy;
    double endDX = endDrag.dx;
    double endDY = endDrag.dy;
    if (startDX > endDX) {
      startDX = endDX;
      endDX = startDrag.dx;
    }
    if (startDY > endDY) {
      startDY = endDY;
      endDY = startDrag.dy;
    }

    update['onLongPressStart'] = getStartOffset(Contstants.leftMargin, hOffset, vOffset, startDX, startDY);
    update['onLongPressEnd'] = getEndOffset(Contstants.leftMargin, hOffset, vOffset, endDX, endDY, size);
    print("calculateOffset -> update  $update, finishedDragging: $finishedDragging");
    return update;
  }
}
