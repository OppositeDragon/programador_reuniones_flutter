import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorarioPersonalWidget extends ConsumerStatefulWidget {
  const HorarioPersonalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HorarioPersonalWidgetState();
}

class _HorarioPersonalWidgetState extends ConsumerState<HorarioPersonalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("Mis horarios"),
    );
  }
}
