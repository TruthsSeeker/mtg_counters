import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/counter_button.dart';
import 'package:mtgcounters/widgets/counter_mini.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/inherited_player_state.dart';

import 'main_display.dart';

class PlayerCountersState extends State<PlayerCounters> {
  final String key;

  Player player;
  String active;
  CounterImages mainImage;
  Color imageColor;
  List<Player> commanders = [];
  ValueChanged<Player> updatePlayer;


  PlayerCountersState({
    this.player,
    this.commanders,
    this.updatePlayer,
    this.active = 'lifepoints',
    this.mainImage = CounterImages.heart,
    this.imageColor = Colors.black,
    this.key = 'Bob'
  }) {
    var commanderMap = commanders.map((commander) => {commander.key: 0}).reduce((v, e) {
      v.addAll(e);
      return v;
    });
    this.player.props.addAll(commanderMap);

  }

  @override
  Widget build(BuildContext context) {
    return _buildCounters(context);
  }

  void update(int value) {
    setState(() {
      player.props[active] += value;
      updatePlayer(player);
    });
  }

  void setActive(String target) {
    setState(() {
      active = target;
    });
  }

  void setActiveImage(CounterImages image) {
    setState(() {
      mainImage = image;
    });
  }

  void setColor(Color color) {
    setState(() {
      imageColor = color;
    });
  }

  List<Widget> getCommanders() {
    List<Widget> list = [];
    commanders.forEach((value) {
      list.add(CounterMini(
        target: value.key,
        image: CounterImages.commander,
        frontColor: value.color,
      ));
    });
    return list;
  }

  Widget _buildCounters(BuildContext context) {
    InheritedGameState gameState = InheritedGameState.of(context);
    return InheritedPlayerState(
      player: player,
      target: active,
      updateValue: update,
      updateTarget: setActive,
      updateColor: setColor,
      updateImage: setActiveImage,
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
                        color: imageColor,
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
  ValueChanged<Player> updatePlayer;

  PlayerCounters(
      this.player,
      this.commanders,
      this.updatePlayer
    );

  @override
  State<StatefulWidget> createState() => PlayerCountersState(player: player, commanders: commanders, key: player.key, updatePlayer: updatePlayer);
}
