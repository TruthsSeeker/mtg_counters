import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';


class Game with ChangeNotifier {
  final _random = new Random();
  final _diceRolls = 7;
  int playerCount = 2;
  int startingLife = 20;
  List<Player> players;
  List<Color> defaultPlayerColors = [Colors.red, Colors.blue, Colors.green, Colors.purple];

  MainDisplayMode _mainDisplayMode = MainDisplayMode.game;
  MainDisplayMode get mainDisplayMode { return _mainDisplayMode; }
  set mainDisplayMode(MainDisplayMode mode) {
    _mainDisplayMode = mode;
    notifyListeners();
  }

  List<List<DiceImages>> _randomValues;
  List<List<DiceImages>> get randomValues { return _randomValues; }
  set randomValues(List<List<DiceImages>> list) {
    _randomValues = list;
    notifyListeners();
  }

  int diceThrowStep = 0;
  int diceThrowWinner;
  Timer _timer;

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
    initPlayers();
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

  throwDice() {
    diceThrowStep = 0;
    List<List<DiceImages>> list = List<List<DiceImages>>.generate(playerCount, (_) => []);
    List<DiceImages> lastRolls = [];
    for (int i = 0; i < playerCount; i++) {
      for (int j = 0; j < _diceRolls; j++){
        list[i].add(DiceImages.values[_random.nextInt(DiceImages.values.length)]);
      }
      lastRolls.add(DiceImages.values[_random.nextInt(DiceImages.values.length)]);
    }
    lastRolls = breakTies(lastRolls);
    list.asMap().forEach((key, value) {
      value.add(lastRolls[key]);
    });
    randomValues = list;
    mainDisplayMode = MainDisplayMode.random;
    diceIsRolling();
  }

  diceIsRolling() {
    if (diceThrowStep < randomValues.first.length - 1) {
        _timer = Timer(Duration(milliseconds: 100), () {
          diceThrowStep++;
          notifyListeners();
          diceIsRolling();
        });
    } else {
      _timer.cancel();
    }
  }

  List<DiceImages> breakTies(List<DiceImages> list) {
    int max = list.map((e) => e.numericalValue)
        .reduce((value, element) => value > element ? value : element);

    Map<int, DiceImages> listMapped = Map<int, DiceImages>.from(list.asMap());
    listMapped.removeWhere((key, value) => value.numericalValue != max);

    List<int> tiesIndices = listMapped.keys.toList();
    if (tiesIndices.length == 1) {
      diceThrowWinner = tiesIndices.first;
      notifyListeners();
      return list;
    }

    List<DiceImages> rerolledLastValues = list;
    for (int index in tiesIndices) {
      rerolledLastValues[index] = DiceImages
          .values[_random.nextInt(DiceImages.values.length)];
    }

    return breakTies(rerolledLastValues);
  }

}

enum MainDisplayMode {
  game,
  random
}