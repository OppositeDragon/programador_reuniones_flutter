import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';

class SemanaHorarioPersonalModel {
  String uid;
  late bool isSet;
  DiaHorarioPersonal D;
  DiaHorarioPersonal L;
  DiaHorarioPersonal M;
  DiaHorarioPersonal X;
  DiaHorarioPersonal J;
  DiaHorarioPersonal V;
  DiaHorarioPersonal S;
  SemanaHorarioPersonalModel({
    required this.uid,
    required this.D,
    required this.L,
    required this.M,
    required this.X,
    required this.J,
    required this.V,
    required this.S,
  }) {
    isSet = false;
    if (D.isActive() || L.isActive() || M.isActive() || X.isActive() || J.isActive() || V.isActive() || S.isActive()) {
      isSet = true;
    }
  }

  List<DiaHorarioPersonal> toListOfDays() {
    return <DiaHorarioPersonal>[D, L, M, X, J, V, S];
  }

  SemanaHorarioPersonalModel fromListOfDays(List<DiaHorarioPersonal> days) {
    return SemanaHorarioPersonalModel(
      uid: uid,
      D: days[0],
      L: days[1],
      M: days[2],
      X: days[3],
      J: days[4],
      V: days[5],
      S: days[6],
    );
  }

  SemanaHorarioPersonalModel copyWith({
    String? uid,
    DiaHorarioPersonal? D,
    DiaHorarioPersonal? L,
    DiaHorarioPersonal? M,
    DiaHorarioPersonal? X,
    DiaHorarioPersonal? J,
    DiaHorarioPersonal? V,
    DiaHorarioPersonal? S,
  }) {
    return SemanaHorarioPersonalModel(
      uid: uid ?? this.uid,
      D: D ?? this.D,
      L: L ?? this.L,
      M: M ?? this.M,
      X: X ?? this.X,
      J: J ?? this.J,
      V: V ?? this.V,
      S: S ?? this.S,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'isSet': isSet});
    result.addAll({'D': D.toMap()});
    result.addAll({'L': L.toMap()});
    result.addAll({'M': M.toMap()});
    result.addAll({'X': X.toMap()});
    result.addAll({'J': J.toMap()});
    result.addAll({'V': V.toMap()});
    result.addAll({'S': S.toMap()});

    return result;
  }

  factory SemanaHorarioPersonalModel.fromMap(Map<String, dynamic> map) {
    return SemanaHorarioPersonalModel(
      uid: map['uid'] ?? '',
      D: DiaHorarioPersonal.fromMap(map['D']),
      L: DiaHorarioPersonal.fromMap(map['L']),
      M: DiaHorarioPersonal.fromMap(map['M']),
      X: DiaHorarioPersonal.fromMap(map['X']),
      J: DiaHorarioPersonal.fromMap(map['J']),
      V: DiaHorarioPersonal.fromMap(map['V']),
      S: DiaHorarioPersonal.fromMap(map['S']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SemanaHorarioPersonalModel.fromJson(String source) => SemanaHorarioPersonalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SemanaHorarioPersonalModel(uid: $uid, isSet: $isSet, D: $D, L: $L, M: $M, X: $X, J: $J, V: $V, S: $S)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SemanaHorarioPersonalModel &&
        other.uid == uid &&
        other.isSet == isSet &&
        other.D == D &&
        other.L == L &&
        other.M == M &&
        other.X == X &&
        other.J == J &&
        other.V == V &&
        other.S == S;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ isSet.hashCode ^ D.hashCode ^ L.hashCode ^ M.hashCode ^ X.hashCode ^ J.hashCode ^ V.hashCode ^ S.hashCode;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
class DiaHorarioPersonal {
  final WeekDays weekDay;
  final Map<TimeSlot, bool> tiempos;

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
    final Map<TimeSlot, bool> timeslots = timesoltsString.map(
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
