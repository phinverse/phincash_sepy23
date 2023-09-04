import 'package:flutter/material.dart';
import 'dart:math' as math;


class Watermark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Transform.rotate(
          angle: -math.pi / 4,
          child: Opacity(
            opacity: 0.1,
            child: Text(
              'PREVIEW',
              style: TextStyle(
                color: Colors.red,
                fontSize: 90,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
