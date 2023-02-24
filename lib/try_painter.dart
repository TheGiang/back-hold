import 'dart:math';

import 'package:flutter/material.dart';

class TryPainter extends CustomPainter {
  TryPainter({
    required this.waveHeights,
    required this.waveWidths,
    required this.animValue,
  });

  final double progress = 100;

  final Paint _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2.0
    ..
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  List<double> waveHeights;
  List<double> waveWidths;
  double animValue;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    double R = size.width / 3;
    // R=0;

    // path.moveTo(0, size.height / 2);
    int totalOfPoint = waveHeights.length ~/ 2;
    // for (int i = 0; i < totalOfPoint; i++) {
    //   path.quadraticBezierTo(
    //     waveWidths[2 * i],
    //     size.height / 2 + waveHeights[2 * i] * animValue,
    //     waveWidths[2 * i + 1],
    //     size.height / 2 + waveHeights[2 * i + 1],
    //   );
    // }
    double rad = (waveWidths[0] / 360) * (2 * pi);

    path.moveTo(size.width / 2 + R, size.height / 2);
    // path.lineTo(size.width/2, size.height/2);
    // double R = 200;
    // for (int i = 0; i <= 200; i++) {
    //   double x = i * 1.0;
    //   double y = sqrt(pow(R, 2) - pow(x, 2));
    //   path.lineTo(x+size.width/2, y+size.height/2);
    // }
    // path.lineTo(size.width/2, size.height/2);
    // animValue = 0;
    double x1, y1, x2, y2;
    // path.lineTo(size.width / 2 + R + 100, size.height / 2 + R);
    for (int i = 0; i < totalOfPoint; i++) {
      double h =
          sqrt(2 * pow(R, 2) * (1 - cos((180 - waveWidths[2 * i]) * (2 * pi))));

      // print('giang.pt1 ${cos((waveWidths[2 * i] / 180) * (2 * pi))}');

      double rad1 = (waveWidths[2 * i] / 360) * (2 * pi);

      // print('pi::$rad');
      h = waveHeights[2 * i].isNegative ? -h : h;

      final R1 = R + (R / (2 * pi)) + (waveHeights[2 * i] * animValue);

      x1 = cos(rad1) * R1;
      y1 = sin(rad1) * R1;

      double rad2 = (waveWidths[2 * i + 1] / 360) * (2 * pi);
      final R2 = R + (waveHeights[2 * i + 1] * animValue);

      x2 = cos(rad2) * R2;
      y2 = sin(rad2) * R2;

      // path.lineTo(x+size.width/2, y+size.height/2);

      path.quadraticBezierTo(
        x1 + size.width / 2,
        y1 + size.height / 2,
        x2 + size.width / 2,
        y2 + size.height / 2,
      );
    }

    // path.lineTo(size.width / 2, size.height / 2 + R);
    path.close();
    canvas.drawPath(path, _paint);
  }

  // @override
  // bool shouldRepaint(LinePainter oldDelegate) {
  //   return oldDelegate.progress != progress;
  // }
// var paint = Paint()
//   ..strokeWidth = 1;
//   // ..shader = const LinearGradient(
//   //   begin: Alignment.topCenter,
//   //   end: Alignment.bottomCenter,
//   //   colors: [Colors.black, Colors.green],
//   // )
//   //     .createShader(Rect.fromPoints(
//   //   Offset.zero,
//   //   Offset(size.width, size.height),
//   // )
//   // );
// var path = Path();
//
// Offset center = const Offset(200, 200);
// int R = 20;
//
// path.lineTo(0, 0);
// path.lineTo(size.width, 0);
// path.lineTo(size.width, size.height);
// path.lineTo(0, size.height);
// path.close();
// // path.moveTo(center.dx, center.dy);
// //
// // path.lineTo(center.dx + R, center.dy);
// //
// // path.close();
// canvas.drawPath(path, paint);
// }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
