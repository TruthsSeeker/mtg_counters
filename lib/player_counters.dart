import 'package:flutter/material.dart';
import 'package:mtgcounters/counter_button.dart';
import 'package:mtgcounters/counter_mini.dart';
import 'package:mtgcounters/inherited_player_state.dart';
import 'package:uuid/uuid.dart';

import 'main_display.dart';

class PlayerCountersState extends State<PlayerCounters> {
  final String key = Uuid().v4();

  double scale;
  Color color;
  String active;

  Map<String, int> props = {};


  PlayerCountersState({
    int lifepoints = 20,
    int poison = 0,
    int storm = 0,
    Map<String, int> commanderDamage = const {},
    this.color = Colors.red,
    this.active = 'lifepoints',
    this.scale = 1,
  }) {
    this.props = {'lifepoints': lifepoints, 'poison':  poison, ...commanderDamage};
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildCounters();
  }

  void update(int value) {
    setState(() {
      props[active] += value;
    });
  }

  void setActive(String target) {
    setState(() {
      active = target;
    });
  }

  Widget _buildCounters() {
    return InheritedPlayerState(
      data: this,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CounterButton(value: -5, image: 'assets/img/-5.png',),
                        CounterButton(value: -1, image: 'assets/img/-.png',),
                      ],
                    ),
                  ),
                  MainDisplay(),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: <Widget>[
                        CounterButton(target: 'lifepoints', value: 5, image: 'assets/img/+5.png',),
                        CounterButton(value: 1, image: 'assets/img/+.png',),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  CounterMini(
                    frontImage: 'assets/img/heart.png',
                    index: 0,
                    target: 'lifepoints',
                  ),
                  CounterMini(
                    frontImage: "assets/img/poison.png",
                    index: 1,
                    target: 'poison',
                  ),
                  CounterMini(
                    frontImage: 'assets/img/shield.png',
                    backImage: 'assets/img/shield-full.png',
                    frontColor: Colors.blueGrey,
                    backColor: Colors.blueAccent,
                    index: 2,
                    target: 'commander_damage',
                  ),
                  CounterMini(
                    frontImage: 'assets/img/shield.png',
                    backImage: 'assets/img/shield-full.png',
                    frontColor: Colors.blueGrey,
                    backColor: Colors.blueAccent,
                    index: 3,
                    target: 'lifepoints',
                  ),
                  CounterMini(
                    frontImage: 'assets/img/shield.png',
                    backImage: 'assets/img/shield-full.png',
                    frontColor: Colors.blueGrey,
                    backColor: Colors.blueAccent,
                    index: 4,
                    target: 'poison',
                  ),
                ],
              ),
            )
          ]),
    );
  }


}

class PlayerCounters extends StatefulWidget {
  double scale;

  PlayerCounters({this.scale = 1});

  @override
  State<StatefulWidget> createState() => PlayerCountersState(scale: this.scale);
}
