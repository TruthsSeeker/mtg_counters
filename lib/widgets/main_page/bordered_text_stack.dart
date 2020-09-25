import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BorderedTextStack extends StatelessWidget {
  final String text;
  final double strokeWidth;

  BorderedTextStack(this.text, [this.strokeWidth = 1.0]);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Text(
            text,
            style:  TextStyle(foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Colors.black,
              fontFeatures: [FontFeature.tabularFigures()])
              ),
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white,
              fontFeatures: [FontFeature.tabularFigures()]),
          ),
        )
      ],
    );
  }
}
