import 'package:black_hole/wave_painter.dart';
import 'package:flutter/material.dart';

class WavesAnim extends StatefulWidget {
  const WavesAnim({Key? key}) : super(key: key);

  @override
  State<WavesAnim> createState() => _WavesAnimState();
}

class _WavesAnimState extends State<WavesAnim> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 6500));
    final Animation<double> curve = CurvedAnimation(
        parent: animationController,
        curve: const Cubic(0.25, 0.1, 0.25, 1.0),
        reverseCurve: Curves.easeInOutSine);
    animation = Tween<double>(begin: 0, end: 1).animate(curve);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.repeat(
        reverse: false, period: const Duration(milliseconds: 6500));
  }

  @override
  Widget build(BuildContext context) {
    var width = -MediaQuery.of(context).size.width;
    return SizedBox(
      height: 500,
      width: 1000,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Transform.translate(
            offset: Offset(animation.value * 5 * width, 0),
            child: Container(
              height: 300,
              width: 1000,
              child: CustomPaint(
                painter: WavePainter(
                  // realSize: Size(-width * 12, 200),
                  colors: [
                    Colors.pink,
                    Colors.purple,
                  ],
                  pick: 20,
                  amount: 8,
                ),
              ),
            ),
          ),
          // Transform.translate(
          //   offset: Offset(animation.value * 1 * width, 0),
          //   child: Container(
          //     height: 250,
          //     width: -width * 6,
          //     child: CustomPaint(
          //       painter: WavePainter(
          //         realSize: Size(-width *12, 200),
          //         colors: [
          //           Colors.red,
          //           Colors.pink,
          //         ],
          //         pick: 30,
          //         amount: 10,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
