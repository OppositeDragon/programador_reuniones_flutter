import 'dart:convert';

import 'package:programador_reuniones_flutter/models/dia_horario_personal.dart';

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
    return 'SemanaHorarioPersonalModel(uid: $uid, D: $D, L: $L, M: $M, X: $X, J: $J, V: $V, S: $S)';
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
