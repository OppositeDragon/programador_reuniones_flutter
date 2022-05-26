import 'dart:convert';

class UserModel {
  String userId;
  String email;
  String user;
  String phone;
  String name;
  String lastName;
  UserModel(
    this.userId,
    this.email,
    this.user,
    this.phone,
    this.name,
    this.lastName,
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
      usuario ?? this.user,
      telefono ?? this.phone,
      nombre ?? this.name,
      apellido ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'email': email});
    result.addAll({'usuario': user});
    result.addAll({'telefono': phone});
    result.addAll({'nombre': name});
    result.addAll({'apellido': lastName});

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
    return 'UserModel(userId: $userId, email: $email, usuario: $user, telefono: $phone, nombre: $name, apellido: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userId == userId &&
        other.email == email &&
        other.user == user &&
        other.phone == phone &&
        other.name == name &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        email.hashCode ^
        user.hashCode ^
        phone.hashCode ^
        name.hashCode ^
        lastName.hashCode;
  }
}
