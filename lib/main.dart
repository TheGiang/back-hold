import 'package:black_hole/try_paint_anim.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '🛠 black_hole_flutter example',
      home: Scaffold(
        appBar: AppBar(title: Text('🛠 black_hole_flutter example')),
        body: Container(
          color: Colors.red,
          width: double.infinity,
          height: 400,
          child: Stack(
            children: [
              Positioned.fill(child: TryPaintAnim()),
              Positioned.fill(child: TryPaintAnim()),
              Positioned.fill(child: TryPaintAnim()),
              Positioned.fill(child: TryPaintAnim()),
            ],
          ),
        ),
      ),
    );
  }
}
