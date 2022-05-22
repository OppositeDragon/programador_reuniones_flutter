import 'dart:convert';

class UserModel {
  String userId;
  String email;
  String usuario;
  String telefono;
  String nombre;
  String apellido;
  UserModel(
    this.userId,
    this.email,
    this.usuario,
    this.telefono,
    this.nombre,
    this.apellido,
  );

  UserModel copyWith({
    String? userId,
    String? email,
    String? usuario,
    String? telefono,
    String? nombre,
    String? apellido,
  }) {
    return UserModel(
      userId ?? this.userId,
      email ?? this.email,
      usuario ?? this.usuario,
      telefono ?? this.telefono,
      nombre ?? this.nombre,
      apellido ?? this.apellido,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'email': email});
    result.addAll({'usuario': usuario});
    result.addAll({'telefono': telefono});
    result.addAll({'nombre': nombre});
    result.addAll({'apellido': apellido});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['userId'] ?? '',
      map['email'] ?? '',
      map['usuario'] ?? '',
      map['telefono'] ?? '',
      map['nombre'] ?? '',
      map['apellido'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, usuario: $usuario, telefono: $telefono, nombre: $nombre, apellido: $apellido)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.email == email &&
        other.usuario == usuario &&
        other.telefono == telefono &&
        other.nombre == nombre &&
        other.apellido == apellido;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        usuario.hashCode ^
        telefono.hashCode ^
        nombre.hashCode ^
        apellido.hashCode;
  }
}
