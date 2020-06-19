import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/game_utility.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/player_counters.dart';

// TODO: Refactor PlayerCounterState to facilitate soft-resets (ie preserving some information re players eg color)
class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final GameTypes gameType;

  int playerCount;
  Map<String, Player> players = {};
  Map<String, PlayerCountersState> playerStates = {};

  _GameState({
    this.playerCount = 2,
    this.gameType = GameTypes.normal
  }) {
    this.initPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return _getColumn();
  }

  initPlayers() {
    for (int i = 0; i < playerCount; i++) {
       var player = Player(startingLife: gameType == GameTypes.normal ? 20 : 40, color: defaultPlayerColors[i % playerCount]);
       players[player.key] = player;
    }
  }

  List<Widget> _getPlayerCountersFor(Player player) {
    List<Player> otherPlayers = Map<String, Player>.from(players).values.toList();
    otherPlayers.remove(player);
    return <Widget>[
      Spacer(flex: 1,),
      Flexible(
        flex: 9,
        fit: FlexFit.tight,
        child: PlayerCounters(player, otherPlayers),
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
                          .expand((x) => x).toList();
    return InheritedGameState(
      playerStates: playerStates,
      stateChanged: setPlayerState,
      child: Column(
        children: <Widget>[
          Spacer(flex: 1,),
          ...widgetList,
          GestureDetector(
            child: Container(
              color: Colors.black,
            ),
            onTap: restartGame,
          )
        ],
      ),
    );
  }

  //TODO: Make that work
  restartGame() {
    setState(() {
      players = Map<String, Player>.from(players);
    });
  }

  setPlayerState(PlayerCountersState state) {
    setState(() {
      this.playerStates[state.key] = state;
    });
  }


}
