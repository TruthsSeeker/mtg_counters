import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/utility/app_scroll_behavior.dart';
import 'package:mtgcounters/widgets/main_page/game_layout.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    Wakelock.enable();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Game(),)
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'MerriweatherSans',
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
                child: Container(
                  color: Color(0xfbf7f5ff),
                  child: SafeArea(
                    top: false,
                    bottom: true,
                      child: GameLayout()),
                )
            ),
          )
      ),
    );
  }
}
