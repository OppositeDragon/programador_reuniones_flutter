import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/controllers/user_controller.dart';
import 'package:programador_reuniones_flutter/widgets/appbar_widget.dart';
import 'package:programador_reuniones_flutter/widgets/formulario_editar_perfil_widget.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    ref.read(userProvider).getUserData();
  }

  void switchIsEditingState() {
    return setState(() {
      _isEditing = !_isEditing;
    });
  }

  bool _isEditing = false;
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider).userData;
    final Color iconColor = Theme.of(context).colorScheme.inversePrimary;

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget('Perfil'),
        body: Center(
          child: userData == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 350),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                              child: !_isEditing
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(50.0),
                                          child: userData['photoURL'] == null
                                              ? Icon(
                                                  Icons.account_circle_outlined,
                                                  size: 120,
                                                  color: Theme.of(context).colorScheme.primary,
                                                )
                                              : Image.network(
                                                  userData['photoURL'],
                                                  height: 150,
                                                ),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.abc, color: iconColor),
                                              const SizedBox(width: 12),
                                              Text(userData['usuario'].toString(), style: const TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.email, color: iconColor),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                  child: Text(userData['email'].toString(),
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      overflow: TextOverflow.fade,
                                                      style: const TextStyle(fontSize: 20))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.person, color: iconColor),
                                              const SizedBox(width: 12),
                                              Text("${userData['nombre'].toString()} ${userData['apellido'].toString()}",
                                                  style: const TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),
                                        if (userData['telefono'] != null)
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.phone_android, color: iconColor),
                                                const SizedBox(width: 12),
                                                Text(userData['telefono'].toString(), style: const TextStyle(fontSize: 20)),
                                              ],
                                            ),
                                          ),
                                        const SizedBox(height: 20),
                                        if (userData['provider'] == 'password')
                                          ElevatedButton(
                                            onPressed: () {
                                              switchIsEditingState();
                                            },
                                            child: Text(_isEditing ? "Actualizar datos" : 'Editar datos'),
                                          ),
                                      ],
                                    )
                                  : FormularioEditarPerfilWidget(userData,switchIsEditingState)),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
