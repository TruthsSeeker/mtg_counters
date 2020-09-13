import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BorderedTextStack extends StatelessWidget {
  String text;

  BorderedTextStack(this.text){}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Text(
            text,
            style:  TextStyle(foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.black)),
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
