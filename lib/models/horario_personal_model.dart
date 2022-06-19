import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';

class SemanaHorarioPersonalModel {
  String uid;
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
  });

  SemanaHorarioPersonalModel copyWith({
    String? userId,
    DiaHorarioPersonal? D,
    DiaHorarioPersonal? L,
    DiaHorarioPersonal? M,
    DiaHorarioPersonal? X,
    DiaHorarioPersonal? J,
    DiaHorarioPersonal? V,
    DiaHorarioPersonal? S,
  }) {
    return SemanaHorarioPersonalModel(
      uid: userId ?? uid,
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
    return 'HorarioPersonalModel(uid: $uid, D: $D, L: $L, M: $M, X: $X, J: $J, V: $V, S: $S)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SemanaHorarioPersonalModel &&
        other.uid == uid &&
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
    return uid.hashCode ^ D.hashCode ^ L.hashCode ^ M.hashCode ^ X.hashCode ^ J.hashCode ^ V.hashCode ^ S.hashCode;
  }
}

class DiaHorarioPersonal {
  WeekDays weekDay;
  List<TimeSlot> tiempos = [];
  List<bool> busy = [];
  DiaHorarioPersonal({required this.weekDay, required this.tiempos, required this.busy})
      : assert(tiempos.length == busy.length, 'La cantidad de tiempos y de busy debe ser igual');

  DiaHorarioPersonal copyWith({WeekDays? weekDay, List<TimeSlot>? tiempos, List<bool>? busy}) {
    return DiaHorarioPersonal(
      weekDay: weekDay ?? this.weekDay,
      tiempos: tiempos ?? this.tiempos,
      busy: busy ?? this.busy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'weekDay': weekDay.name});
    result.addAll({'tiempos': tiempos.map((x) => x.start).toList()});
    result.addAll({'busy': busy});

    return result;
  }

  factory DiaHorarioPersonal.fromMap(Map<String, dynamic> map) {
    return DiaHorarioPersonal(
      weekDay: WeekDays.values.firstWhere((element) => element.name == map['weekDay']),
      tiempos: timeSlotsFromListString(map['tiempos']),
      busy: List<bool>.from(map['busy']),
    );
  }
  static List<TimeSlot> timeSlotsFromListString(List<String> stringList) {
    List<TimeSlot> timeSlots = [];
    for (String time in stringList) {
      timeSlots.add(TimeSlot.values.firstWhere((element) => element.start == time));
    }
    return timeSlots;
  }

  String toJson() => json.encode(toMap());

  factory DiaHorarioPersonal.fromJson(String source) => DiaHorarioPersonal.fromMap(json.decode(source));

  @override
  String toString() => 'DiaDeHorarioPersonal(weekDay: $weekDay, tiempos: $tiempos, busy: $busy)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiaHorarioPersonal && other.weekDay == weekDay && listEquals(other.tiempos, tiempos) && listEquals(other.busy, busy);
  }

  @override
  int get hashCode => weekDay.hashCode ^ tiempos.hashCode ^ busy.hashCode;
}
