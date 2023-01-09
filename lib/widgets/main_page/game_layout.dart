import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/main_page/player_counter_container.dart';
import 'package:mtgcounters/widgets/main_page/randomizer_container.dart';
import 'package:mtgcounters/widgets/menu/menu.dart';
import 'package:provider/provider.dart';

import '../menu/confirm_reset.dart';

class GameLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 55),
          child: Row(
            children: _getColumn(context),
          ),
        ),
        _getColoredPadding(context),
        Menu(),
        if (Provider.of<Game>(context).showAlert)
          ConfirmReset()
      ],
    );
  }

  List<List<Player>> _splitPlayers(List<Player> players) {
    var middle = players.length ~/ 2;
    var i = 0;

    if (players.length <= 2) {
      return [players];
    }

    List<Player> right = [];
    List<Player> left = [];

    players.forEach((value) {
      if (i < middle) {
        left.add(value);
      } else {
        right.add(value);
      }
      i++;
    });

    return [left, right];
  }

  List<List<int>> _getRotations(List<List<Player>> splitPlayers) {
    if (splitPlayers.length == 2) {
      var leftRotations = splitPlayers[0].map((x) => 1).toList();
      var rightRotations = splitPlayers[1].map((x) => 3).toList();
      return [leftRotations, rightRotations];
    } else {
      if (splitPlayers[0].length == 1) {
        return [[0]];
      } else {
        return [[2,0]];
      }
    }
  }

  List<Widget> _getWidgets(BuildContext context, List<Player> players, List<int> rotations) {
    final MainDisplayMode mode = Provider.of<Game>(context).mainDisplayMode;

    if (mode == MainDisplayMode.game) {
      List<Widget> playerWidgets = [];
      for (int i = 0; i<players.length; i++) {
        playerWidgets.add(ChangeNotifierProvider<Player>.value(
            value: players[i],
            child: PlayerCounterContainer(player: players[i], quarterTurns: rotations[i],)
        ));
      }
      return playerWidgets;

    } else {
      List<Widget> randomWidgets = [];
      for (int i = 0; i<players.length; i++) {
        randomWidgets.add(ChangeNotifierProvider<Player>.value(
            value: players[i],
            child: RandomizerContainer(players[i], rotations[i])
        ));
      }
      return randomWidgets;
    }
  }

  List<Widget> _getColumn(BuildContext context) {
    final playerList = Provider.of<Game>(context).players;
    final splitList = _splitPlayers(playerList);
    final rotations = _getRotations(splitList);
    List<Widget> widgetList = [];

    for (int i=0; i<splitList.length; i++) {
      widgetList.add(Flexible(
        flex: 1,
        child: Column(
          children: <Widget>[
            ..._getWidgets(context, splitList[i], rotations[i]),
//              Spacer(flex: 1,),
          ],
        ),
      ));
    }
    return widgetList;
  }

  List<Color> _getBottomColors(BuildContext context) {
    List<Player> players = Provider.of<Game>(context).players;
    List<Color> colors = [];
    List<List<Player>> splitList = _splitPlayers(players);
    for (List<Player> list in splitList) {
      colors.add(list.last.color);
    }
    return colors;
  }

  Widget _getColoredPadding(BuildContext context) {
    List<Color> colors = _getBottomColors(context);
    List<Widget> coloredContainers = colors.map((e) {
      return Expanded(
          child: Container(
            color: e,
          )
      );
    }).toList();

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 55,
      child: Row(

        children: [...coloredContainers],
      ),
    );
  }
}
