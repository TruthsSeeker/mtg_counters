import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtgcounters/utility/app_scroll_behavior.dart';
import 'package:mtgcounters/widgets/game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

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
        home: Scaffold(
          body: ScrollConfiguration(
              behavior: AppScrollBehavior(),
              child: Game()
          ),
        )
    );
  }
}
