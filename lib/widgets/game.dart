import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/game_utility.dart';
import 'package:mtgcounters/widgets/game_layout.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/menu_bar.dart';
import 'package:mtgcounters/widgets/player_counter_container.dart';

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
        child: GameLayout(),
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

  restartGame() {
    setState(() {
      players.forEach((k, v) => v.reset());
    });
  }

  update(Player player) {
    setState(() {
      players[player.key].color = player.color;
      players[player.key].props.forEach((k, v) => {
        players[player.key].props.update(k, (existingValue) => player.props[k], ifAbsent: () => player.props[k])
      });
    });
  }
}
