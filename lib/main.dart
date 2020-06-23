import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtgcounters/widgets/game.dart';
import 'package:mtgcounters/widgets/player_counters.dart';

void main() => runApp(MyApp());

//TODO: Remove device orientation as layout factor
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: 'Merriweather'),
        home: Scaffold(
          body: Game(),
        )
    );
  }
}
