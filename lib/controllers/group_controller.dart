import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/models/grupo_model.dart';
import 'package:programador_reuniones_flutter/models/user_model.dart';

final groupProvider = ChangeNotifierProvider<GroupController>((ref) {
  return GroupController();
});
final getGruposProvider = StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  final a = ref.watch(groupProvider);
  return a.getGrupos();
});

/// Clase que controla el todo lo relacionado con los grupos, creacion, edicion, borrado, etc

class GroupController with ChangeNotifier {
  /// [Set] de [UserModel] que contiene los usuarios que pertenecen a un grupo
  Set<UserModel> _listaUsuarios = {};

  /// Objeto de tipo [GroupModel] que contiene los datos del grupo actual, pero se inicializa con [GroupModel.empty]
  GroupModel _groupData = GroupModel.empty();

  /// Objeto temporal de tipo [GroupModel] que contiene los datos del grupo actual, pero se inicializa con [GroupModel.empty], usado para la edicen de un grupo
  GroupModel _groupDataTemp = GroupModel.empty();

  /// [get]ter para [_listaUsuarios] [returns]  un [Set] de [UserModel].
  Set<UserModel> get listaUsuarios => _listaUsuarios;

  /// [get]ter para [_groupData] [returns] un [GroupModel].
  GroupModel get groupData => _groupData;

  /// [get]ter para [_groupDataTemp] [returns] un [GroupModel].
  GroupModel get groupDataTemp => _groupDataTemp;

  ///[set]er para establecer el nombre del grupo, toma un [String] como parametro y lo establece en [_groupDataTemp.nombre]
  ///
  ///'''dart
  ///nombreGrupo = 'Nombre del grupo';
  ///entonces _groupDataTemp.nombre = nombreGrupo;
  ///'''
  set nombreGrupo(String nombre) => _groupDataTemp.nombre = nombre;

  ///[set]er para establecer la descripcion del grupo, toma un [String] como parametro y lo establece en [_groupDataTemp.descripcion]
  set descripcionGrupo(String descripcion) => _groupDataTemp.descripcion = descripcion;

  /// Crea un grupo, toma un [nombre], [descripcion] y [listaUsuarios] como parametros,
  /// y los agrega a la base de datos.
  /// [SetOptions] tiene la opcion merge establecido en [true]
  Future<String> createGroup(String nombre, String descripcion, Set<UserModel> integrantes) async {
    Set<String> members = {};
    members.add(FirebaseAuth.instance.currentUser!.uid);
    for (var element in integrantes) {
      members.add(element.userId);
    }
    final document = FirebaseFirestore.instance.collection("groups").doc();

    await document.set({
      'docId': document.id,
      'nombre': nombre,
      'descripcion': descripcion,
      'admin': FirebaseAuth.instance.currentUser!.uid,
      'integrantes': members.toList(),
    }, SetOptions(merge: true));
    return document.id;
  }

  /// Actualiza el grupo actual, toma el [groupId], [nombre], [descripcion], [reunionTime] e [integrantes] como parametros,
  /// [reunionTime] puede ser enviado como [null] o [String].
  /// [SetOptions] no se establece en este metodo.
  Future<void> updateGroup(String groupId, String nombre, String descripcion, String? reunionTime, Set<UserModel> integrantes) async {
    Set<String> members = {};
    members.add(FirebaseAuth.instance.currentUser!.uid);
    for (var element in integrantes) {
      members.add(element.userId);
    }
    await FirebaseFirestore.instance.collection("groups").doc(groupId).update(<String, dynamic>{'integrantes': FieldValue.delete()});
    await FirebaseFirestore.instance.collection("groups").doc(groupId).set({
      'docId': groupId,
      'nombre': nombre,
      'descripcion': descripcion,
      'admin': FirebaseAuth.instance.currentUser!.uid,
      'integrantes': members.toList(),
      'reunionTime': reunionTime
    });
    // resetGroupData();
    notifyListeners();
  }

  /// Obtiene un grupo, toma un [groupId] como parametro, y lo obtiene de la base de datos.
  /// [returns] un [GroupModel], envuelto en [Future].
  Future<GroupModel> getGroupById(String? groupId) async {
    final docRef = await FirebaseFirestore.instance.collection("groups").doc(groupId).get();
    final groupdata = docRef.data();
    final Set<UserModel> integrantes = await getIntegrantes(groupdata!['integrantes']);
    final groupData = GroupModel(
        docId: groupdata['docId'],
        descripcion: groupdata['descripcion'],
        admin: groupdata['admin'],
        nombre: groupdata['nombre'],
        reunionTime: groupdata['reunionTime'],
        integrantes: integrantes);
    _groupData = groupData;
    _groupDataTemp = groupData.copyWith();
    notifyListeners();
    return _groupData;
  }

  /// Busca usuarios de la aplicacion, toma un [value] de tipo [String] como parametro,
  /// que puede ser un nombre de usuario , un correo electronico.
  /// este metodo llama a los metodos [getUsersByUser] y [getUsersByEmail]
  /// y los une en un solo [Set], asi evita duplicidad.
  /// Este [Set] de [UserModel] se guarda en la variable [_listaUsuarios].
  Future<void> searchUsers(String value) async {
    Set<UserModel> setUsuarios = {};
    final usersByUser = await getUsersByUser(value);
    final usersByEmail = await getUsersByEmail(value);
    for (final element in usersByUser.docs) {
      final user = element.data();
      setUsuarios.add(UserModel(
        userId: element.id,
        email: user['email'],
        usuario: user['usuario'],
        telefono: user['telefono'],
        nombre: user['nombre'],
        apellido: user['apellido'],
        proveedor: user['proveedor'],
      ));
    }
    for (final element in usersByEmail.docs) {
      final user = element.data();
      setUsuarios.add(UserModel(
        userId: element.id,
        email: user['email'],
        usuario: user['usuario'],
        telefono: user['telefono'],
        nombre: user['nombre'],
        apellido: user['apellido'],
        proveedor: user['proveedor'],
      ));
    }
    _listaUsuarios = setUsuarios;
    notifyListeners();
  }

  /// Obtiene una lista de usuarios, toma un [username] como parametro, y lo obtiene de la base de datos.
  Future<QuerySnapshot<Map<String, dynamic>>> getUsersByUser(String username) async {
    final usersRef = await FirebaseFirestore.instance
        .collection("users")
        .where("usuario", isGreaterThanOrEqualTo: username)
        .where("usuario", isLessThanOrEqualTo: '$username\uf8ff')
        .get();

    return usersRef;
  }

  /// Obtiene una lista de usuarios, toma un [email] como parametro, y lo obtiene de la base de datos.
  Future<QuerySnapshot<Map<String, dynamic>>> getUsersByEmail(String email) async {
    final usersRef = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isGreaterThanOrEqualTo: email)
        .where("email", isLessThanOrEqualTo: '$email\uf8ff')
        .get();
    return usersRef;
  }

  ///Obtiene los grupos en los que se encuentar el usuario autenticado.
  /// [returns] un [Stream] de [QuerySnapshot].
  Stream<QuerySnapshot<Map<String, dynamic>>> getGrupos() {
    final grupos = FirebaseFirestore.instance
        .collection("groups")
        .where(
          'integrantes',
          arrayContains: FirebaseAuth.instance.currentUser!.uid,
        )
        .snapshots();
    return grupos;
  }

  /// Obtiene los datos de la [lIntegrantes] que toma como parametro.
  /// Los [returns] como un [Set] de [UserModel].
  Future<Set<UserModel>> getIntegrantes(List<dynamic> lIntegrantes) async {
    final Set<UserModel> integrantes = {};
    for (String element in lIntegrantes) {
      if (element.isNotEmpty) {
        final integrante = await FirebaseFirestore.instance.collection('users').doc(element).get();
        final user = integrante.data();
        integrantes.add(UserModel(
          userId: integrante.id,
          email: user!['email'],
          usuario: user['usuario'],
          telefono: user['telefono'],
          nombre: user['nombre'],
          apellido: user['apellido'],
          proveedor: user['proveedor'],
        ));
      }
    }
    groupData.integrantes = integrantes;
    notifyListeners();
    return integrantes;
  }

  ///Permite agregar un integrate al grupo, toma como parametro un objeto [UserModel],
  /// y lo agrega los integrates del objeto [_groupDataTemp].
  void addIntegrante(UserModel user) {
    Set<UserModel> integrantes = {};
    integrantes.add(user);
    for (var element in _groupDataTemp.integrantes) {
      integrantes.add(element);
    }
    _groupDataTemp.integrantes = integrantes;
    notifyListeners();
  }

  ///Permite remover un integrate del grupo, toma como parametro un objeto [UserModel],
  /// y lo elimina de los integrates del objeto [_groupDataTemp].
  void removeIntegrate(UserModel integrante) {
    Set<UserModel> integrantes = {};
    for (var element in _groupDataTemp.integrantes) {
      if (element != integrante) integrantes.add(element);
    }
    _groupDataTemp.integrantes = integrantes;
    notifyListeners();
  }

  /// Establece las variables [_groupDataTemp] y [_groupData] con los valores por defecto [GroupModel.empty].
  void resetGroupData() {
    _groupData = GroupModel.empty();
    _groupDataTemp = GroupModel.empty();
  }

  /// Elimina un grupo de la base de datos. Toma como parametro un [groupId] de tipo [String].
  void deleteGroup(String idGroup) {
    FirebaseFirestore.instance.collection("groups").doc(idGroup).delete();
  }
}
