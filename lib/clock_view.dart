import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Get current time
    final dateTime = DateTime.now();

    // Define clock coordinates and radius
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    // Create paint objects for clock base
    var fillBrush = Paint();
    fillBrush.color = const Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    var centerFillBrush = Paint();
    centerFillBrush.color = const Color(0xFFEAECFF);

    // Draw the base of a clock
    canvas.drawCircle(center, radius - 40, outlineBrush);
    canvas.drawCircle(center, radius - 40, fillBrush);

    // Create paint objects for clock hands
    var secHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    var minHandBrush = Paint()
      ..color = Colors.lightBlue.shade300
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    var hourHandBrush = Paint()
      ..color = Colors.pink.shade300
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;

    // Define clock hands' end point
    var secHandX = centerX + cos(pi * dateTime.second * 6 / 180) * 80;
    var secHandY = centerY + sin(pi * dateTime.second * 6 / 180) * 80;

    var minHandX = centerX + cos(pi * dateTime.minute * 6 / 180) * 80;
    var minHandY = centerY + sin(pi * dateTime.minute * 6 / 180) * 80;

    var hourHandX = centerX +
        cos(pi * (dateTime.hour * 30 + dateTime.minute * 0.5) / 180) * 60;
    var hourHandY = centerY +
        sin(pi * (dateTime.hour * 30 + dateTime.minute * 0.5) / 180) * 60;

    // Draw clock hands
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    // Draw center ball in the clock
    canvas.drawCircle(center, 16, centerFillBrush);

    // Create and draw outer dashes
    final outerCircleRadius = radius;
    final innerCircleRadius = radius - 14;
    final dashBrush = Paint()
      ..color = Colors.yellow
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    for (int i = 0; i < 360; i += 30) {
      final x1 = radius + innerCircleRadius * cos(pi * (i / 180));
      final y1 = radius + innerCircleRadius * sin(pi * (i / 180));
      final x2 = radius + outerCircleRadius * cos(pi * (i / 180));
      final y2 = radius + outerCircleRadius * sin(pi * (i / 180));

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
