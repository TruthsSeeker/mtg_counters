import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtgcounters/widgets/game.dart';

void main() => runApp(MyApp());

//TODO: Remove device orientation as layout factor
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Merriweather',
          textTheme: TextTheme(
            overline: TextStyle(foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black),
            headline4: TextStyle(color: Colors.white)
          ),
        ),
        home: Game()
    );
  }
}
