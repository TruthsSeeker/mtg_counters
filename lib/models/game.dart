import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';


class Game with ChangeNotifier {
  int playerCount = 2;
  int startingLife = 20;
  List<Player> players;
  List<Color> defaultPlayerColors = [Colors.red, Colors.blue, Colors.green, Colors.purple];

  Game() {
    initPlayers();
  }

  initPlayers() {
    players = [];

    for (int i = 0; i < playerCount; i++) {
      var player = Player(startingLife: startingLife, color: defaultPlayerColors[i % playerCount], index: i);
      players.add(player);
    }

    players.forEach((player) {
      Map<String, int> otherPlayers = players
            .where((element) => element.index != player.index)
            .map((e) => {e.index.toString(): 0})
            .reduce((value, element) => {...value, ...element});
      player.props.addAll(otherPlayers);
      // player.notifyListeners();
    });
    notifyListeners();
  }

  restartGame() {
    players.forEach((player) => player.reset());
    notifyListeners();
  }


  updatePlayerCount(int count) {
    playerCount = count;
    initPlayers();
    notifyListeners();
  }

  setStartingLife(int startingLife) {
    this.startingLife = startingLife;
    players.forEach((player) {
      player.startingLife = startingLife;
      player.reset();
    });
    notifyListeners();
  }

  saveColorChange(Color color, Player player){
      defaultPlayerColors[player.index] = color;
      notifyListeners();
  }
}