import 'package:black_hole/try_paint_anim.dart';
import 'package:black_hole/try_painter.dart';
import 'package:black_hole/waves_anim.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
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
          child: TryPaintAnim(),
        ),
      ),
    );
  }
}
