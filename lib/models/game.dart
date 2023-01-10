import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Game with ChangeNotifier {
  final _CONFIRM_RESET_KEY = "confirm_reset";
  final _random = new Random();
  final _diceRolls = 7;

  int playerCount = 2;
  int startingLife = 20;
  List<Player> players = [];
  List<Color> defaultPlayerColors = [Colors.red, Colors.blue, Colors.green, Colors.purple];

  bool showAlert = false;
  bool _shouldDisplayResetConfirm = true;
  bool get confirmReset => _shouldDisplayResetConfirm;
  set confirmReset(bool shouldConfirm) {
    _shouldDisplayResetConfirm = shouldConfirm;
  }

  MainDisplayMode _mainDisplayMode = MainDisplayMode.game;
  MainDisplayMode get mainDisplayMode { return _mainDisplayMode; }
  set mainDisplayMode(MainDisplayMode mode) {
    _mainDisplayMode = mode;
    notifyListeners();
  }

  List<List<DiceImages>> _randomValues = [];
  List<List<DiceImages>> get randomValues { return _randomValues; }
  set randomValues(List<List<DiceImages>> list) {
    _randomValues = list;
    notifyListeners();
  }

  int diceThrowStep = 0;
  int diceThrowWinner = 0;
  Timer? _timer;

  Game() {
    bool? pref;
    SharedPreferences.getInstance().then((instance) => {
      if (instance.getBool(_CONFIRM_RESET_KEY) != null) {
        confirmReset = instance.getBool(_CONFIRM_RESET_KEY)!
      }
    });
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

  displayAlert() {
    showAlert = true;
    print(showAlert);
  }

  setResetConfirmDisplay(bool shouldDisplay) {
    _shouldDisplayResetConfirm = shouldDisplay;
    saveResetConfirmSetting(shouldDisplay);
  }

  Future<void> saveResetConfirmSetting(bool shouldDisplay) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_CONFIRM_RESET_KEY, shouldDisplay);
  }

  shouldConfirmReset() {
    return _shouldDisplayResetConfirm;
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
    Map<int, DiceImages> lastRolls = {};

    for (int i = 0; i < playerCount; i++) {
      for (int j = 0; j < _diceRolls; j++){
        list[i].add(DiceImages.values[_random.nextInt(DiceImages.values.length)]);
      }
      lastRolls[i] = DiceImages.values[_random.nextInt(DiceImages.values.length)];
    }
    lastRolls = breakTies(lastRolls);

    lastRolls.forEach((key, value) {
      list[key].add(value);
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
      _timer?.cancel();
    }
  }

  Map<int, DiceImages> breakTies(Map<int, DiceImages> diceImages) {
    Map<int, DiceImages> ties = Map<int, DiceImages>.from(diceImages);
    int max = 0;

    for (DiceImages image in diceImages.values) {
      if (image.intValue > max) {
        max = image.intValue;
      }
    }

    ties.removeWhere((key, value) => value.intValue < max);

    if (ties.length == 1) {
      diceThrowWinner = ties.keys.first;
      notifyListeners();
      return diceImages;
    }

    Map<int, DiceImages> rerolledLastValues = diceImages;
    for (int index in ties.keys) {
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