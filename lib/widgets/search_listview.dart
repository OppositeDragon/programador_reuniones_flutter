import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                labelText: 'Buscar usuario',
                hintText: 'Puede buscar por email o nombre de usuario',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                if (value.length >= 3) ref.read(groupProvider).getUsers(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: sugerencias.length,
                itemBuilder: (context, index) {
                  final sugerencia = sugerencias[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text((sugerencia.name.isEmpty ? '' : sugerencia.name[0]) + (sugerencia.lastName.isEmpty ? '' : sugerencia.lastName[0])),
                    ),
                    title: Text(sugerencia.user),
                    subtitle: Text(sugerencia.email),
                    onTap: () {
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