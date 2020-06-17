import 'package:flutter/material.dart';
import 'package:mtgcounters/counter_button.dart';
import 'package:mtgcounters/counter_mini.dart';
import 'package:mtgcounters/image_utility.dart';
import 'package:mtgcounters/inherited_player_state.dart';
import 'package:uuid/uuid.dart';

import 'main_display.dart';

class PlayerCountersState extends State<PlayerCounters> {
  final String key = Uuid().v4();
  final Color color;

  String active;
  CounterImages mainImage;
  Color imageFront;
  Color imageBack;
  Map<String, int> _commanders = {};
  Map<String, int> props = {};


  PlayerCountersState({
    int lifepoints = 20,
    int poison = 0,
    int storm = 0,
    Map<String, int> commanderDamage = const {'Alice': 0, 'Bob': 0, 'Charlie':0},
    this.color = Colors.red,
    this.active = 'lifepoints',
    this.mainImage = CounterImages.heart,
    this.imageFront = Colors.black,
  }) {
    this.props = {'lifepoints': lifepoints, 'poison':  poison, ...commanderDamage};
    this._commanders = commanderDamage;
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


  //TODO: Get commander colors
  //Perhaps through player id?
  List<Widget> getCommanders() {
    List<Widget> list = [];
    _commanders.forEach((key, value) {
      list.add(CounterMini(
        target: key,
        image: CounterImages.commander,
        frontColor: Colors.black,
        backColor: Colors.redAccent,
      ));
    });
    return list;
  }

  //TODO: add reset button
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

  PlayerCounters();

  @override
  State<StatefulWidget> createState() => PlayerCountersState();
}
