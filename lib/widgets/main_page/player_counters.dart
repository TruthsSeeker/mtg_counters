import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:mtgcounters/widgets/main_page/counter_button.dart';
import 'package:mtgcounters/widgets/main_page/counter_mini.dart';
import 'package:provider/provider.dart';

import 'main_display.dart';

class PlayerCounters extends StatelessWidget {
  final Player player;
  final List<Player> commanders;

  PlayerCounters({
    this.player,
    this.commanders,
  });


  @override
  Widget build(BuildContext context) {
    return _buildCounters(context);
  }




  List<Widget> getCommanders() {
    List<Widget> list = commanders.map((e) => CounterMini(
      target: e.index.toString(),
      image: CounterImages.commander,
      frontColor: e.color,
    )).toList();
    return list;
  }

  Widget _buildCounters(BuildContext context) {
    return ChangeNotifierProvider<Player>(
      create: (_) => player,
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
                        // CounterButton(value: -5, image: 'assets/img/-5.png',),
                        CounterButton(value: -1, image: 'assets/img/-.png',),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 14,
                      child: MainDisplay()
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: <Widget>[
                        // CounterButton(value: 5, image: 'assets/img/+5.png',),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
