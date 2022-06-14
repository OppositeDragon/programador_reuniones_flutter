import 'dart:convert';

class UserModel {
  String userId;
  String email;
  String usuario;
  String telefono;
  String nombre;
  String apellido;
  String proveedor;
  late String userAndEmail;

  UserModel({
    required this.userId,
    required this.email,
    required this.usuario,
    required this.telefono,
    required this.nombre,
    required this.apellido,
    required this.proveedor,
  }) {
    userAndEmail = '$usuario  ($email)';
  }

  UserModel copyWith({
    String? userId,
    String? email,
    String? usuario,
    String? telefono,
    String? nombre,
    String? apellido,
    String? proveedor,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      usuario: usuario ?? this.usuario,
      telefono: telefono ?? this.telefono,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      proveedor: proveedor ?? this.proveedor,
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
    result.addAll({'proveedor': proveedor});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
      usuario: map['usuario'] ?? '',
      telefono: map['telefono'] ?? '',
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      proveedor: map['proveedor'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userId: $userId, email: $email, usuario: $usuario, telefono: $telefono, nombre: $nombre, apellido: $apellido, proveedor: $proveedor)';
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
        other.apellido == apellido &&
        other.proveedor == proveedor;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ email.hashCode ^ usuario.hashCode ^ telefono.hashCode ^ nombre.hashCode ^ apellido.hashCode ^ proveedor.hashCode;
  }
}
