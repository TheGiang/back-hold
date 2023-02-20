import 'dart:math';

import 'package:black_hole/try_painter.dart';
import 'package:flutter/material.dart';

class TryPaintAnim extends StatefulWidget {
  const TryPaintAnim({Key? key}) : super(key: key);

  @override
  State<TryPaintAnim> createState() => _TryPaintAnimState();
}

class _TryPaintAnimState extends State<TryPaintAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> curve;

  late Animation alpha;

  List<double> waveHeights = [];
  List<double> waveWidths = [];
  bool isCurveTop = true;

  @override
  void initState() {
    super.initState();
    tryPaint();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          tryPaint();
          _controller.forward();
        }
      })
      ..forward();

    curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    alpha = Tween<double>(begin: 0, end: 1.0).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: alpha,
      builder: (BuildContext context, Widget? child) {
        // print('giang.pt1 AnimatedBuilder::${alpha.value}');
        //
        // print('giang.pt1 _controller.status2::${_controller.status}');
        return CustomPaint(
          painter: TryPainter(
              waveHeights: waveHeights,
              waveWidths: waveWidths,
              animValue: alpha.value),
        );
      },
    );
  }

  void tryPaint() {
    waveHeights.clear();
    waveWidths.clear();
    // Size size = Size(430, 400);

    Random _rdm = Random();

    int totalOfPoint = _rdm.nextInt(5) + 5;

    double curWidth = 0;
    double step = 360 / totalOfPoint / 2;

    double totalOfHeight = 0;

    for (int i = 0; i < totalOfPoint; i++) {
      double tmp = _rdm.nextInt(1) + 1;
      tmp=1;
      waveHeights.add((tmp * (isCurveTop ? 1 : -1)));
      waveHeights.add(0);
      totalOfHeight += tmp;
      isCurveTop = !isCurveTop;
    }

    for (int i = 0; i < totalOfPoint; i++) {
      double height = waveHeights[2 * i].abs();
      double width = 360 * (height / totalOfHeight) / 2;
      waveWidths.add(double.parse((curWidth += width).toStringAsFixed(1)));
      waveWidths.add(double.parse((curWidth += width).toStringAsFixed(1)));
    }

    print('giang.pt1 totalOfPoint::$totalOfPoint');
    print('giang.pt1 waveHeights::${waveHeights.toString()}');
    print('giang.pt1 waveWidths::${waveWidths.toString()}');
  }
}
