import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtgcounters/widgets/player_counters.dart';

void main() => runApp(MyApp());

//TODO: Multiple players bound together for commander damage
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(fontFamily: 'Merriweather'),
        home: Scaffold(
          body: Column(
              children: <Widget>[
                Spacer(flex: 1,),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Row(
                      children: <Widget>[
                        Spacer(flex: 1,),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: PlayerCounters(),
                        ),
                        Spacer(flex: 2,),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: PlayerCounters(),
                        ),
                        Spacer(flex: 1,),
                      ]
                  ),
                ),
                Spacer(flex: 1,),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Row(
                      children: <Widget>[
                        Spacer(flex: 1,),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: PlayerCounters(),
                        ),
                        Spacer(flex: 2,),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: PlayerCounters(),
                        ),
                        Spacer(flex: 1,),
                      ]
                  ),
                ),
                Spacer(flex: 1,),
              ]
          ),
        )
    );
  }
}
