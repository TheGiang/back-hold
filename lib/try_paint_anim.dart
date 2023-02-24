import 'dart:math';

import 'package:black_hole/try_painter.dart';
import 'package:flutter/material.dart';

class TryPaintAnim extends StatefulWidget {
  const TryPaintAnim({Key? key}) : super(key: key);

  @override
  State<TryPaintAnim> createState() => _TryPaintAnimState();
}

class _TryPaintAnimState extends State<TryPaintAnim>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> curve;
  late Animation<double> alpha;

  List<double> waveHeights = [];
  List<double> waveWidths = [];
  bool isCurveTop = true;

  @override
  void initState() {
    super.initState();
    tryPaint();

    Random _rdm = Random();
    final sec = _rdm.nextInt(5) + 5;
    _controller = AnimationController(
      duration: Duration(seconds: sec),
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

    curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
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
        return RotationTransition(
          turns: alpha,
          child: CustomPaint(
            painter: TryPainter(
                waveHeights: waveHeights,
                waveWidths: waveWidths,
                animValue: alpha.value),
          ),
        );
      },
    );
  }

  void tryPaint() {
    waveHeights.clear();
    waveWidths.clear();
    // Size size = Size(430, 400);

    Random _rdm = Random();

    int totalOfPoint = _rdm.nextInt(2) * 2 + 4;

    totalOfPoint = 6;

    double curWidth = 0;
    double step = 360 / totalOfPoint / 2;

    double totalOfHeight = 0;

    for (int i = 0; i < totalOfPoint; i++) {
      double tmp = _rdm.nextInt(10) + (50 / totalOfPoint);
      // tmp = 10;
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
