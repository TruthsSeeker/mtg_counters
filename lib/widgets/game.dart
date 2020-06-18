import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/game_utility.dart';
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
    this.playerCount,
    this.gameType
  }) {
    this.initPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  initPlayers() {
    for (int i = 0; i < playerCount; i++) {
       var player = Player(defaultPlayerColors[i], type: gameType);
       players[player.key] = player;
    }
  }

  List<Widget> _getPlayerCountersFor(Player player) {
    return <Widget>[
      Spacer(flex: 1,),
      Flexible(
        flex: 9,
        fit: FlexFit.tight,
        child: PlayerCounters(),
      ),
      Spacer(flex: 1,)
    ];
  }

  Widget _getRow(List<Player> players) {
    var playerWidgets = players
                          .map((player) => _getPlayerCountersFor(player))
                          .expand((x) => x);
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

  Widget _getColumn() {
    final splitList = _splitPlayers();
    final widgetList = splitList
                          .map((playerColumn) => [
                            _getRow(playerColumn),
                            Spacer(flex: 1,),
                          ])
                          .expand((x) => x);
    return Column(
      children: <Widget>[
        Spacer(flex: 1,),
        ...widgetList
      ],
    );
  }


}
