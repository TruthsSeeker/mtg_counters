import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/game_utility.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/navigation_tab_bar.dart';

class Game extends StatefulWidget {
  final int playerCount;
  final int startingLife;

  Game({
    this.playerCount = 2,
    this.startingLife = 20,
  });

  @override
  _GameState createState() => _GameState(playerCount: playerCount, startingLife: startingLife);
}

class _GameState extends State<Game> {
  int startingLife;
  int playerCount;
  Map<String, Player> players = {};

  _GameState({
    this.playerCount,
    this.startingLife
  }) {
    this.initPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedGameState(
          child: NavigationTabBar(),
          playerStates: players,
          startingLife: startingLife,
          playerChanged: update,
          restart: restartGame,
          playerCountChanged: updatePlayerCount,
          startingLifeChanged: setStartingLife,
    );
  }

  initPlayers() {
    players = {};
    for (int i = 0; i < playerCount; i++) {
      var player = Player(startingLife: startingLife, color: defaultPlayerColors[i % playerCount]);
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

  updatePlayerCount(int count) {
    setState(() {
      playerCount = count;
      initPlayers();
    });
  }

  setStartingLife(int startingLife) {
    setState(() {
      this.startingLife = startingLife;
      initPlayers();
    });
  }
}
