import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/game_utility.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/menu_bar.dart';
import 'package:mtgcounters/widgets/player_counter_container.dart';
import 'package:mtgcounters/widgets/player_counters.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final GameTypes gameType;

  int playerCount;
  Map<String, Player> players = {};

  _GameState({
    this.playerCount = 4,
    this.gameType = GameTypes.normal
  }) {
    this.initPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedGameState(
        child: _getColumn(context),
        playerStates: players,
        playerChanged: update,
    );
  }

  initPlayers() {
    for (int i = 0; i < playerCount; i++) {
       var player = Player(startingLife: gameType == GameTypes.normal ? 20 : 40, color: defaultPlayerColors[i % playerCount]);
       players[player.key] = player;
    }
  }

  Widget _getRow(BuildContext context, List<Player> players) {
    var playerWidgets = players
                          .map((player) => PlayerCounterContainer(player: player));
    return Flexible(
      flex: 4,
      child: Row(
        children: <Widget>[...playerWidgets],
      ),
    );
  }

  List<List<Player>> _splitPlayers() {
    var playerList = players.values.toList();
    var middle = players.length ~/ 2;
    var i = 0;

    if (players.length <= 2) {
      return [playerList];
    }

    List<Player> bottom = [];
    List<Player> top = [];

    playerList.forEach((value) {
      if (i < middle) {
        bottom.add(value);
      } else {
        top.add(value);
      }
      i++;
    });

    return [top, bottom];
  }

  Widget _getColumn(BuildContext context) {
    final splitList = _splitPlayers();
    final widgetList = splitList
                          .map((playerColumn) => [
                            _getRow(context, playerColumn),
                            Spacer(flex: 1,),
                          ])
                          .expand((x) => x).toList();
    return Column(
        children: <Widget>[
          Spacer(flex: 1,),
          ...widgetList,
          GestureDetector(
            child: MenuBar(),
            onTap: restartGame,
          )
        ],
    );
  }

  restartGame() {
    setState(() {
      players.forEach((k, v) => v.reset());
    });
  }

  void update(Player player) {
    setState(() {
      players[player.key].color = player.color;
      players[player.key].props.forEach((k, v) => {
        players[player.key].props.update(k, (existingValue) => player.props[k], ifAbsent: () => player.props[k])
      });
    });
  }
}
