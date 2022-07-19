import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';

////////////////////////////////////////////////////////////////////////////////////////////////////
class DiaHorarioPersonal {
  final WeekDays weekDay;
  final Map<TimeSlot, dynamic> tiempos;

  DiaHorarioPersonal({
    required this.weekDay,
    required this.tiempos,
  });

  bool isActive() {
    for (var element in tiempos.values) {
      if (element == true) {
        return true;
      }
    }
    return false;
  }

  Map<String, String> getChuncksOfTime() {
    Map<String, String> chuncks = {};
    String prev = '';
    String current = '';
    //consolidate time slots with the true value
    for (int i = 1; i < TimeSlot.values.length; i++) {
      if (tiempos[TimeSlot.values[i - 1]] == true && tiempos[TimeSlot.values[i]] == true) {
        if (prev == '') {
          prev = TimeSlot.values[i - 1].start;
        }
        current = TimeSlot.values[i].start;

        if (i == TimeSlot.values.length - 1) {
          chuncks.addAll({prev: current});
        }
      } else if (tiempos[TimeSlot.values[i - 1]] == true && tiempos[TimeSlot.values[i]] == false) {
        if (prev == '') {
          prev = TimeSlot.values[i - 1].start;
        }
        current = TimeSlot.values[i - 1].start;
        chuncks.addAll({prev: current});
        prev = current = '';
      } else if (tiempos[TimeSlot.values[i - 1]] == false && tiempos[TimeSlot.values[i]] == true) {
        prev = current = TimeSlot.values[i].start;
        if (i == TimeSlot.values.length - 1) {
          chuncks.addAll({prev: current});
        }
      }
    }
    return chuncks;
  }

  Map<String, String> getChuncksOfTimeGrupal() {
    Map<String, String> chuncks = {};
    String prev = '';
    String current = '';
    //consolidate time slots with the 0 value
    for (int i = 1; i < TimeSlot.values.length; i++) {
      if (tiempos[TimeSlot.values[i - 1]] == 0 && tiempos[TimeSlot.values[i]] == 0) {
        if (prev == '') {
          prev = TimeSlot.values[i - 1].start;
        }
        current = TimeSlot.values[i].end;

        if (i == TimeSlot.values.length - 1) {
          chuncks.addAll({prev: current});
        }
      } else if (tiempos[TimeSlot.values[i - 1]] == 0 && tiempos[TimeSlot.values[i]] > 0) {
        if (prev == '') {
          prev = TimeSlot.values[i - 1].start;
        }
        current = TimeSlot.values[i - 1].end;
        chuncks.addAll({prev: current});
        prev = current = '';
      } else if (tiempos[TimeSlot.values[i - 1]] == 0 && tiempos[TimeSlot.values[i]] == 0) {
        prev = TimeSlot.values[i].start;
        current = TimeSlot.values[i].end;
        if (i == TimeSlot.values.length - 1) {
          chuncks.addAll({prev: current});
        }
      }
    }
    return chuncks;
  }

  DiaHorarioPersonal copyWith({
    WeekDays? weekDay,
    Map<TimeSlot, bool>? tiempos,
  }) {
    return DiaHorarioPersonal(
      weekDay: weekDay ?? this.weekDay,
      tiempos: tiempos ?? this.tiempos,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'weekDay': weekDay.name});
    result.addAll({'tiempos': tiempos.map((key, value) => MapEntry(key.start.toString(), value))});

    return result;
  }

  factory DiaHorarioPersonal.fromMap(Map<String, dynamic> map) {
    final timesoltsString = map['tiempos'] as Map;
    final Map<TimeSlot, dynamic> timeslots = timesoltsString.map(
      (key, value) => MapEntry(TimeSlot.values.firstWhere((element) => element.start == key), value),
    );
    return DiaHorarioPersonal(
      weekDay: WeekDays.values.firstWhere((element) => element.name == map['weekDay']),
      tiempos: timeslots,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiaHorarioPersonal.fromJson(String source) => DiaHorarioPersonal.fromMap(json.decode(source));

  @override
  String toString() => 'DiaHorarioPersonal(weekDay: $weekDay, tiempos: $tiempos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final mapEquals = const DeepCollectionEquality().equals;

    return other is DiaHorarioPersonal && other.weekDay == weekDay && mapEquals(other.tiempos, tiempos);
  }

  @override
  int get hashCode => weekDay.hashCode ^ tiempos.hashCode;
}
