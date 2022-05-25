import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GruposPersonal extends ConsumerStatefulWidget {
  const GruposPersonal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GruposPersonalState();
}

class _GruposPersonalState extends ConsumerState<GruposPersonal> {
  late List<String> items = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: ListView.separated(
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
        ),
      ),
    );
  }
}
