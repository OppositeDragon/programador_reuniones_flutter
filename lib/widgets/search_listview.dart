import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/constants/strings.dart';
import 'package:programador_reuniones_flutter/controllers/group_controller.dart';

class SearchListView extends ConsumerWidget {
  const SearchListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sugerencias = ref.watch(groupProvider).listaUsuarios;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: Strings.labelBuscarUsuario,
                hintText: Strings.hintBuscar,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                if (value.length >= 3) ref.read(groupProvider).searchUsers(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: sugerencias.length,
                itemBuilder: (context, index) {
                  final sugerencia = sugerencias.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(
                      child:
                          Text((sugerencia.nombre.isEmpty ? '' : sugerencia.nombre[0]) + (sugerencia.apellido.isEmpty ? '' : sugerencia.apellido[0])),
                    ),
                    title: Text(sugerencia.usuario),
                    subtitle: Text(sugerencia.email),
                    onTap: () {
                      // ref.read(groupProvider).addIntegrante(sugerencia);
                      Navigator.of(context).pop(sugerencia);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
