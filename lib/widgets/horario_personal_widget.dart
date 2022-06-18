import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                child: HorarioPersonalPainter(constraints.maxWidth),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HorarioPersonalPainter extends StatefulWidget {
  const HorarioPersonalPainter(
    this.width, {
    super.key,
  });

  final double width;

  @override
  State<HorarioPersonalPainter> createState() => _HorarioPersonalPainterState();
}

class _HorarioPersonalPainterState extends State<HorarioPersonalPainter> {
  GlobalKey gridKey = new GlobalKey();
  void selectItem(GlobalKey<State<StatefulWidget>> gridItemKey, var details) {
    RenderBox _boxItem = gridItemKey.currentContext!.findRenderObject()! as RenderBox;
    final _boxMainGrid = gridKey.currentContext!.findRenderObject()! as RenderBox;
    Offset position = _boxMainGrid.localToGlobal(Offset.zero); //this is global position
    double gridLeft = position.dx;
    double gridTop = position.dy;

    double gridPosition = details.globalPosition.dy - gridTop;

    //Get item position
    int rowIndex = (gridPosition / _boxItem.size.width).floor().toInt();
    int colIndex = ((details.globalPosition.dx - gridLeft) / _boxItem.size.width).floor().toInt();
    // gridState[rowIndex][colIndex] = "Y";
    print("rowIndex: $rowIndex, colIndex: $colIndex");
    //  setState(() {});
  }

  Map<String, dynamic> drag = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          // onTapDown: (details) {
          //   print('details: localPosition${details.localPosition} globalPosition:${details.globalPosition}, kind:${details.kind}');
          // },
          onLongPressStart: (details) {
            print('onLongPressStart: localPosition${details.localPosition} globalPosition:${details.globalPosition}');
            drag['onLongPressStart'] = details.localPosition;
            HapticFeedback.mediumImpact();

          //  setState(() {});
          },
          onLongPressMoveUpdate: (details) {
				setState(() {
				   drag['onLongPressEnd'] = details.localPosition;
				});
			},
          onLongPressEnd: (details) {
            print('onLongPressEnd: localPosition${details.localPosition} globalPosition:${details.globalPosition}, kind:${details.velocity}');
            drag['onLongPressEnd'] = details.localPosition;
            print(drag);
            HapticFeedback.vibrate();
            setState(() {});
          },
          // onPanUpdate: (DragUpdateDetails details) {
          //   print('onPanUpdate');
          //   print(details.localPosition);
          // },
          // onLongPressMoveUpdate: (details) {
          //   print(
          //       'onLongPressMoveUpdate: localPosition${details.localPosition} globalPosition:${details.globalPosition}, localOffsetFromOrigin:${details.localOffsetFromOrigin} offsetFromOrigin: ${details.offsetFromOrigin}');
          // },
          child: CustomPaint(
            key: gridKey,
            size: Size(widget.width - 10,970),
            painter: HorarioPainter(
              primaryColor: theme.textTheme.bodyText1!.color!,
              brightness: theme.brightness,
              update: drag,
            ),
          ),
        ),
      ],
    );
  }
}
