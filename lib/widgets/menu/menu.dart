import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/widgets/menu/player_count_menu_item.dart';
import 'package:mtgcounters/widgets/menu/reset_game_menu_item.dart';
import 'package:mtgcounters/widgets/menu/starting_life_menu_item.dart';

class Menu extends StatelessWidget {
  final List<Widget> elementList = [
    ResetGameMenuItem(),
    PlayerCountMenuItem(),
    StartingLifeMenuItem(),
    //TODO
    new Text('Player settings placeholder'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      itemCount: elementList.length,
      itemBuilder: (BuildContext context, int index) => elementList[index],
      separatorBuilder: (BuildContext context, int index) => const Divider(),

    );
  }
}
