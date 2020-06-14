import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtgcounters/player_counters.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Merriweather'),
      home: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 200,
              maxHeight: 200,
              maxWidth: 300,
              minWidth: 300,
            ),
              child: PlayerCounters(scale: 1)),
        ),
      )
    );
  }
}
