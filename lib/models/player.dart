import 'dart:ui';
import 'package:mtgcounters/utility/game_utility.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Player {
  String key;
  int startingLife;
  Color color;

  Player({
      String key,
      this.color,
      this.startingLife}) {
    this.key = key ?? uuid.v4();
  }
}=