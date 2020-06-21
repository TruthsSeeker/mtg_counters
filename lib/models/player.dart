import 'dart:ui';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Player {
  final int startingLife;
  String key;
  Color color;
  String active;
  Map<String, int> props = {};

  Player({
      String key,
      this.color,
      this.startingLife,
      this.active = 'lifepoints'}) {
    this.key = key ?? uuid.v4();
    this.props = {'lifepoints': startingLife, 'poison':  0, 'storm': 0};
  }

  reset() {
    this.active = 'lifepoints';
    this.props.updateAll((k, v) {
      if (k == 'lifepoints') {
        return startingLife;
      }
      return 0;
    });
  }
}