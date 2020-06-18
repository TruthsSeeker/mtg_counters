import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/counter_button.dart';
import 'package:mtgcounters/widgets/counter_mini.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:mtgcounters/widgets/inherited_player_state.dart';
import 'package:uuid/uuid.dart';

import 'main_display.dart';

class PlayerCountersState extends State<PlayerCounters> {
  final String key = Uuid().v4();
  final Color color;

  String active;
  CounterImages mainImage;
  Color imageFront;
  Color imageBack;
  List<Player> commanders = [];
  Map<String, int> props = {};


  PlayerCountersState({
    int lifepoints = 20,
    int poison = 0,
    int storm = 0,
    this.commanders,
    this.color = Colors.red,
    this.active = 'lifepoints',
    this.mainImage = CounterImages.heart,
    this.imageFront = Colors.black,
  }) {
    var commanderMap = commanders.map((commander) => {commander.key: 0}).reduce((v, e) {
      v.addAll(e);
      return v;
    });
    this.props = {'lifepoints': lifepoints, 'poison':  poison, ...commanderMap};

  }

  @override
  Widget build(BuildContext context) {
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

  void setActiveImage(CounterImages image, Color frontColor, Color backColor) {
    setState(() {
      mainImage = image;
      imageFront = frontColor;
      imageBack = backColor;
    });
  }


  void setCommanders(Map<String, int> data) {
    setState(() {
      data.forEach((key, value) => props[key] = value);
    });
  }


  List<Widget> getCommanders() {
    List<Widget> list = [];
    commanders.forEach((value) {
      list.add(CounterMini(
        target: value.key,
        image: CounterImages.commander,
        frontColor: Colors.black,
        backColor: value.color,
      ));
    });
    return list;
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
                  Expanded(
                    flex: 14,
                      child: MainDisplay(
                        image: mainImage,
                        front: imageFront,
                        back: imageBack,
                      )
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: <Widget>[
                        CounterButton(value: 5, image: 'assets/img/+5.png',),
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
                    image: CounterImages.heart,
                    start: true,
                    target: 'lifepoints',
                  ),
                  CounterMini(
                    image: CounterImages.poison,
                    target: 'poison',
                  ),
                  ...getCommanders()
                ],
              ),
            )
          ]),
    );
  }
}

class PlayerCounters extends StatefulWidget {
  Player player;
  List<Player> commanders = [];

  PlayerCounters(
      @required this.player,
      this.commanders
    );

  @override
  State<StatefulWidget> createState() => PlayerCountersState(lifepoints: player.startingLife, color: player.color, commanders: commanders);
}
