import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/constants/constants.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';
import 'package:programador_reuniones_flutter/models/horario_personal_model.dart';

class HorarioPainter extends CustomPainter {
  final SemanaHorarioPersonalModel horarioSemanal;
  final ThemeData theme;
  final Map<String, Offset> update;
  HorarioPainter({
    required this.horarioSemanal,
    required this.theme,
    required this.update,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //calculate offsets
    final hOffset = (size.width - Contstants.leftMargin) / 7;
    final vOffset = (size.height - Contstants.bottomMargin) / 96;
    // colors to be used
    final textColor = theme.textTheme.bodyText1!.color!;
    final hourLineColor = theme.brightness == ui.Brightness.dark ? const Color.fromRGBO(235, 235, 235, 0.8) : const Color.fromRGBO(45, 45, 45, 0.8);
    final midHourLineColor =
        theme.brightness == ui.Brightness.dark ? const Color.fromRGBO(160, 160, 160, 0.8) : const Color.fromRGBO(90, 90, 90, 0.8);
    // instantiate paint objects
    final hourBrush = Paint()
      ..color = hourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.2;
    final quarterHourBrush = Paint()
      ..color = midHourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.75;
    final midHourBrush = Paint()
      ..color = midHourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    final verticalBrush = Paint()
      ..color = midHourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    final timeBrush = Paint()
      ..color = theme.colorScheme.secondary
      ..style = ui.PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;
    final timeBrush2 = Paint()..color = theme.colorScheme.secondary.withOpacity(0.3);
    final updateBrushFill = Paint()..color = theme.colorScheme.primary.withOpacity(0.65);
    final updateBrushStroke = Paint()
      ..color = theme.colorScheme.primary.withOpacity(0.85)
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 3;

    // draw drag update
    if (update['onLongPressStart'] != null && update['onLongPressEnd'] != null) {
      print('${update['onLongPressStart']!} ${update['onLongPressEnd']!}');
      final Rect rect = Rect.fromPoints(update['onLongPressStart']!, update['onLongPressEnd']!);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Contstants.radiusRRect), updateBrushFill);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Contstants.radiusRRect), updateBrushStroke);
    }
    //text configuration
    final paragraphStyle = ui.ParagraphStyle(textDirection: TextDirection.ltr, textAlign: TextAlign.right);
    final textStyleBig = ui.TextStyle(color: textColor, fontSize: 11, fontWeight: FontWeight.w600);
    final textStyleSmall = ui.TextStyle(color: textColor, fontSize: 9);
    const widhtConstraints43 = ui.ParagraphConstraints(width: 43);
    const widhtConstraints40 = ui.ParagraphConstraints(width: 40);
    //draw the timetext
    for (var i = 0; i < Contstants.horasDia.length; i++) {
      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle((i % 2 == 0) ? textStyleSmall : textStyleBig)
        ..addText(Contstants.horasDia[i]);
      final paragraph = paragraphBuilder.build()..layout((i % 2 == 0) ? widhtConstraints43 : widhtConstraints40);
      final double dy = ((i + 1) * vOffset * 2) - 3;
      canvas.drawParagraph(paragraph, (i % 2 == 0) ? Offset(0, dy) : Offset(0, dy - 2));
    }
    //draws the horizontal lines
    canvas.drawLine(const Offset(44, 0.5), Offset(size.width, 0.5), hourBrush);
    for (int i = 1; i <= 96; i++) {
      final double dy = i * vOffset + 1;
      if (i % 4 == 0) {
        canvas.drawLine(Offset(40, dy), Offset(size.width, dy), hourBrush);
      } else if (i % 2 == 0) {
        drawDashedLine(canvas, size, midHourBrush, Contstants.leftMargin, dy, 3, 3);
      } else {
        if (size.height > 700) drawDashedLine(canvas, size, quarterHourBrush, Contstants.leftMargin, dy, 3, 1);
      }
    }
    //draws vertical lines
    for (var i = 7; i >= 0; i--) {
      final double dx = (size.width - 0.5) - i * hOffset;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height - Contstants.bottomMargin), verticalBrush);
    }
    //
    final List<DiaHorarioPersonal> horarioDias = horarioSemanal.toListOfDays();
    double dx = 45;
    for (int i = 0; i < horarioDias.length; i++) {
      for (var element in horarioDias[i].getChuncksOfTime().entries) {
        final double dy1 = TimeSlot.values.firstWhere((timesSlot) => timesSlot.start == element.key).i * vOffset;
        final double dy2 = TimeSlot.values.firstWhere((timesSlot) => timesSlot.start == element.value).i * vOffset + vOffset;
        final Rect rect = Rect.fromPoints(Offset(dx + 1, dy1 + 2.5), Offset(dx + hOffset - 2, dy2 - 0.5));
        canvas.drawRRect(RRect.fromRectAndRadius(rect, Contstants.radiusRRect), timeBrush2);
        canvas.drawRRect(RRect.fromRectAndRadius(rect, Contstants.radiusRRect), timeBrush);
      }
      dx += hOffset;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is HorarioPainter &&
        (theme != oldDelegate.theme || update != oldDelegate.update || horarioSemanal == oldDelegate.horarioSemanal);
  }

  void drawDashedLine(ui.Canvas canvas, ui.Size size, ui.Paint brush, double leftMargin, double dy, int space, int dash) {
    double startX = leftMargin;
    while (startX < size.width) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, dy), Offset(startX + dash, dy), brush);
      // Update the starting X
      startX += dash + space;
    }
  }
}
