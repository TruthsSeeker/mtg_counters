import 'dart:ui';
import 'package:mtgcounters/utility/game_utility.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Player {
  final String key = uuid.v4();
  int startingLife;
  Color color;

  Player(this.color, {GameTypes type = GameTypes.normal}) {
    switch (type) {
      case GameTypes.normal:
        this.startingLife = 20;
        break;
      case GameTypes.commander:
        this.startingLife = 40;
        break;
    }
  }

}