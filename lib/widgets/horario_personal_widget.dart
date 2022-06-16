import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programador_reuniones_flutter/constants/constants.dart';
import 'package:programador_reuniones_flutter/painters/horario_painter.dart';

class HorarioPersonalWidget extends ConsumerStatefulWidget {
  const HorarioPersonalWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HorarioPersonalWidgetState();
}

class _HorarioPersonalWidgetState extends ConsumerState<HorarioPersonalWidget> {
  @override
  Widget build(BuildContext context) {
	
		final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  for (int i = 0; i < Contstants.dias.length; i++) Flexible(flex: 2, child: Center(child: Text(Contstants.dias[i]))),
                  const SizedBox(width: 6),
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight - 31,
              child: SingleChildScrollView(
                primary: false,
                child: CustomPaint(
                  size: Size(constraints.maxWidth - 10, 1165),
                  painter: HorarioPainter(primaryColor:theme.textTheme.bodyText1!.color!,brightness:theme.brightness),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
