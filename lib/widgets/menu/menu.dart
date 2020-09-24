import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/utility/app_scroll_behavior.dart';
import 'package:mtgcounters/widgets/menu/player_color_selection_menu_item.dart';
import 'package:mtgcounters/widgets/menu/player_count_menu_item.dart';
import 'package:mtgcounters/widgets/menu/reset_game_menu_item.dart';
import 'package:mtgcounters/widgets/menu/starting_life_menu_item.dart';

class Menu extends StatelessWidget {
  final List<Widget> elementList = [
    Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
      constraints: BoxConstraints(
        maxHeight: 10,
        maxWidth: 20,
      ),
      child: Image.asset('assets/img/rounded-line.png'),
    ),
    ResetGameMenuItem(),
    PlayerCountMenuItem(),
    StartingLifeMenuItem(),
    //TODO
    PlayerColorSelectionMenuItem()
    //TODO
    //CommanderDamageToggleMenuItem()

  ];
  @override
  Widget build(BuildContext context) {
    // return ListView.separated(
    //   padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
    //   itemCount: elementList.length,
    // itemBuilder: (BuildContext context, int index) => elementList[index],
    // separatorBuilder: (BuildContext context, int index) => const Divider(),
    //
    // );
    return DraggableScrollableSheet(
        minChildSize: 0.1,
        maxChildSize: 0.75,
        initialChildSize: 0.1,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              decoration: new BoxDecoration(
                  color: Color(0xfbf7f5ff),
                  borderRadius: new BorderRadius.only(
                      topLeft:  const  Radius.circular(16.0),
                      topRight: const  Radius.circular(16.0))
              ),
              child: ScrollConfiguration(
                behavior: AppScrollBehavior(),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: elementList.length,
                    itemBuilder: (BuildContext context, int index) => elementList[index],
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
              )
          );
        }
    );

  }
}
