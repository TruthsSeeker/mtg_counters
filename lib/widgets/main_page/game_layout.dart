import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/main_page/player_counter_container.dart';
import 'package:mtgcounters/widgets/menu/menu.dart';
import 'package:provider/provider.dart';

class GameLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: _getColumn(context),
        ),
        Menu(),
      ],
    );
  }

  List<List<Player>> _splitPlayers(List<Player> players) {
    var middle = players.length ~/ 2;
    var i = 0;

    if (players.length <= 2) {
      return [players];
    }

    List<Player> bottom = [];
    List<Player> top = [];

    players.forEach((value) {
      if (i < middle) {
        bottom.add(value);
      } else {
        top.add(value);
      }
      i++;
    });

    return [top, bottom];
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

  Widget _getRow(BuildContext context, List<Player> players, List<int> rotations) {
    List<PlayerCounterContainer> playerWidgets = [];
    for (int i = 0; i<players.length; i++) {
      playerWidgets.add(PlayerCounterContainer(player: players[i], quarterTurns: rotations[i],));
    }
    return Flexible(
      flex: 4,
      child: Column(
        children: <Widget>[...playerWidgets],
      ),
    );
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
            _getRow(context, splitList[i], rotations[i]),
//              Spacer(flex: 1,),
          ],
        ),
      ));
    }
    return widgetList;
  }
}
