import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GruposPersonal extends ConsumerStatefulWidget {
  const GruposPersonal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GruposPersonalState();
}

class _GruposPersonalState extends ConsumerState<GruposPersonal> {
  late List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15"
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: Stack(
          children: [
            ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: CircleAvatar(),
                  title: Text('One-line with both widgets'),
                  subtitle: Text('ezta es la descripcion'),
                  trailing: Icon(Icons.more_vert),
                );
              },
              addSemanticIndexes: true,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, right: 15),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed('nuevo-grupo');
                  },
                  child: const Text("Nuevo"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
