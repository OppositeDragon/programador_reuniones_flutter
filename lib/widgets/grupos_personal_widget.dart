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
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return const Card(
          child: ListTile(
            leading: CircleAvatar(),
            title: Text('One-line with both widgets'),
            trailing: Icon(Icons.more_vert),
          ),
        );
      },
    );
  }
}
