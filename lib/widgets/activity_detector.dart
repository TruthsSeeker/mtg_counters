import 'dart:async';

import 'package:flutter/widgets.dart';

//TODO: Theme Management to enable dimming of screen while inactive

class _ActivityDetectorState extends State<ActivityDetector> {
  Widget child;
  Timer _timer;

  _ActivityDetectorState(this.child);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: initTimer,
      child: child,
    );
  }

  initTimer() {
    if (_timer == null) {
      _timer = Timer(Duration(seconds: 30), () {

      });
    }
  }
}

class ActivityDetector extends StatefulWidget {
  Widget child;

  ActivityDetector(this.child);

  @override
  _ActivityDetectorState createState() => _ActivityDetectorState(child);
}
