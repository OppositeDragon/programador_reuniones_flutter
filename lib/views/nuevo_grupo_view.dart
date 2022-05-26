import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NuevoGrupo extends StatefulWidget {
  const NuevoGrupo({Key? key}) : super(key: key);

  @override
  State<NuevoGrupo> createState() => _NuevoGrupoState();
}

class _NuevoGrupoState extends State<NuevoGrupo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
      ]),
      body: Container(
        child: Title(
          color: Theme.of(context).primaryColorDark,
          child: const Text("Nuevo grupo"),
        ),
      ),
    );
  }
}
