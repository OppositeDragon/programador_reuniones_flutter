import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:programador_reuniones_flutter/constants/constants.dart';

class HorarioPainter extends CustomPainter {
  final Color primaryColor;
  final ui.Brightness brightness;
  HorarioPainter({required this.primaryColor, required this.brightness});

  @override
  void paint(Canvas canvas, Size size) {
    final hourLineColor = brightness == ui.Brightness.dark ? const Color.fromRGBO(235, 235, 235, 0.8) : const Color.fromRGBO(45, 45,45, 0.8);
    final midHourLineColor = brightness == ui.Brightness.dark ? const Color.fromRGBO(160,160,160, 0.8) : const Color.fromRGBO(90,90,90, 0.8);
    final hOffset = (size.width - 45) / 7;
    final hourBrush = Paint()
      ..color = hourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    final quarterHourBrush = Paint()
      ..color = midHourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.75;
    final midHourBrush = Paint()
      ..color =  midHourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;
    final verticalBrush = Paint()
      ..color = midHourLineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

//text
    final paragraphStyle = ui.ParagraphStyle(textDirection: TextDirection.ltr);
    final textStyleBig = ui.TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.w600);
    final textStyleSmall = ui.TextStyle(color: primaryColor, fontSize: 9);
//draw the timetext
    for (var i = 0; i < Contstants.horasDia.length; i++) {
      final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle((i % 2 == 0) ? textStyleSmall : textStyleBig)
        ..addText(Contstants.horasDia[i]);
      final paragraph = paragraphBuilder.build()..layout(const ui.ParagraphConstraints(width: 40));
      final double dy = i * 24 + 21;
      canvas.drawParagraph(paragraph, (i % 2 == 0) ? Offset(20, dy) : Offset(12, dy -2));
    }

//draws the horizontal lines
    canvas.drawLine(const Offset(44,0.5), Offset(size.width, 0.5), hourBrush);
    for (int i = 1; i <= 96; i++) {
      final double dy = i * 12 + 1;

      if (i % 4 == 0) {
        canvas.drawLine(Offset(40, dy), Offset(size.width, dy), hourBrush);
      } else if (i % 2 == 0) {
        drawDashedLine(canvas, size, midHourBrush, dy, 6, 7);
      } else {
        drawDashedLine(canvas, size, quarterHourBrush, dy, 6, 3);
      }
    }
    for (var i = 0; i <= 7; i++) {
      final double dx = i * hOffset + 44;
      canvas.drawLine(Offset(dx, 0), Offset(dx, 24 * 12 * 4), verticalBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    //oldDelegate is HorarioPainter && (primaryColor != oldDelegate.primaryColor);
  }

  void drawDashedLine(ui.Canvas canvas, ui.Size size, ui.Paint brush, double dy, int space, int dash) {
    double startX = 45;
    while (startX < size.width) {
      // Draw a small line.
      canvas.drawLine(Offset(startX, dy), Offset(startX + dash, dy), brush);
      // Update the starting X
      startX += dash + space;
    }
  }
}
