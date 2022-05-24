import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';

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
        return const GFListTile(
            avatar: GFAvatar(),
            titleText: 'GetWidget Library',
            subTitleText: 'This is a open source UI library.',
            icon: Icon(Icons.favorite, color: Colors.red));
      },
    );
  }
}
