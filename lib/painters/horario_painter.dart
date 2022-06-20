import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/constants/constants.dart';
import 'package:programador_reuniones_flutter/models/enums.dart';
import 'package:programador_reuniones_flutter/models/horario_personal_model.dart';

class HorarioPainter extends CustomPainter {
  final Color primaryColor;
  final ui.Brightness brightness;
  final SemanaHorarioPersonalModel horarioSemanal;
  final Map<String, dynamic> update;
  HorarioPainter({required this.primaryColor, required this.brightness, required this.update, required this.horarioSemanal});

  @override
  void paint(Canvas canvas, Size size) {
    //
    print('chuncksoftime: ${horarioSemanal.D.getChuncksOfTime()}');
//calculate offsets
    const double bottomMargin = 10;
    const double leftMargin = 45;
    final hOffset = (size.width - leftMargin) / 7;
    final vOffset = (size.height - bottomMargin) / 96;
    print('vOffset: $vOffset');
    final hourLineColor = brightness == ui.Brightness.dark ? const Color.fromRGBO(235, 235, 235, 0.8) : const Color.fromRGBO(45, 45, 45, 0.8);
    final midHourLineColor = brightness == ui.Brightness.dark ? const Color.fromRGBO(160, 160, 160, 0.8) : const Color.fromRGBO(90, 90, 90, 0.8);

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
//
    final updateBrush = Paint()
      ..color = Colors.indigo.shade900.withOpacity(0.5)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    print('${update['onLongPressStart']} ${update['onLongPressEnd']}');
    if (update['onLongPressStart'] != null && update['onLongPressEnd'] != null) {
      canvas.drawRect(Rect.fromPoints(update['onLongPressStart'], update['onLongPressEnd']), updateBrush);
    }
    //
//text
    final paragraphStyle = ui.ParagraphStyle(textDirection: TextDirection.ltr, textAlign: TextAlign.right);
    final textStyleBig = ui.TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w600);
    final textStyleSmall = ui.TextStyle(color: primaryColor, fontSize: 9);
//draw the timetext
    for (var i = 0; i < Contstants.horasDia.length; i++) {
      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle((i % 2 == 0) ? textStyleSmall : textStyleBig)
        ..addText(Contstants.horasDia[i]);
      final paragraph = paragraphBuilder.build()
        ..layout((i % 2 == 0) ? const ui.ParagraphConstraints(width: 43) : const ui.ParagraphConstraints(width: 40));
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
        drawDashedLine(canvas, size, midHourBrush, leftMargin, dy, 3, 3);
      } else {
        drawDashedLine(canvas, size, quarterHourBrush, leftMargin, dy, 3, 1);
      }
    }

    //draws vertical lines
    for (var i = 7; i >= 0; i--) {
      final double dx = (size.width - 0.5) - i * hOffset;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height - bottomMargin), verticalBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is HorarioPainter) {
      print('update ${update == oldDelegate.update}');
      print('newupdate ${update['onLongPressStart']} ${update['onLongPressEnd']}');
      print('oldupdate ${oldDelegate.update['onLongPressStart']} ${oldDelegate.update['onLongPressEnd']}');
      print('shouldRepaint ${oldDelegate is HorarioPainter && (primaryColor != oldDelegate.primaryColor || update != oldDelegate.update)}');
    }
    return true; //oldDelegate is HorarioPainter && (primaryColor != oldDelegate.primaryColor || update != oldDelegate.update);
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
