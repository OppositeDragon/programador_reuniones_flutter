import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:programador_reuniones_flutter/models/user_model.dart';

class GroupModel {
  String docId;
  String descripcion;
  String admin;
  String nombre;
  Set<UserModel> integrantes;
  GroupModel({
    required this.docId,
    required this.descripcion,
    required this.admin,
    required this.nombre,
    required this.integrantes,
  });
  GroupModel.empty({
    this.docId = '',
    this.descripcion = '',
    this.admin = '',
    this.nombre = '',
    this.integrantes = const {},
  });
  GroupModel copyWith({
    String? docId,
    String? descripcion,
    String? admin,
    String? nombre,
    Set<UserModel>? integrantes,
  }) {
    return GroupModel(
      docId: docId ?? this.docId,
      descripcion: descripcion ?? this.descripcion,
      admin: admin ?? this.admin,
      nombre: nombre ?? this.nombre,
      integrantes: integrantes ?? this.integrantes,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'docId': docId});
    result.addAll({'descripcion': descripcion});
    result.addAll({'admin': admin});
    result.addAll({'nombre': nombre});
    result.addAll({'integrantes': integrantes.map((x) => x.toMap()).toList()});

    return result;
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      docId: map['docId'] ?? '',
      descripcion: map['descripcion'] ?? '',
      admin: map['admin'] ?? '',
      nombre: map['nombre'] ?? '',
      integrantes: Set<UserModel>.from(map['integrantes']?.map((x) => UserModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) => GroupModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupModel(docId: $docId, descripcion: $descripcion, admin: $admin, nombre: $nombre, integrantes: $integrantes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupModel &&
        other.docId == docId &&
        other.descripcion == descripcion &&
        other.admin == admin &&
        other.nombre == nombre &&
        setEquals(other.integrantes, integrantes);
  }

  @override
  int get hashCode {
    return docId.hashCode ^ descripcion.hashCode ^ admin.hashCode ^ nombre.hashCode ^ integrantes.hashCode;
  }
}
