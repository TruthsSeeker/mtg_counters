import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Player {
  int startingLife;
  String key;
  Color color;
  String active;
  Map<String, int> props = {};

  Player({
      this.key,
      this.color,
      this.startingLife,
      this.active = 'lifepoints'}) {
    this.key = key ?? uuid.v4();
    this.props = {'lifepoints': startingLife, 'poison':  0, 'storm': 0};
  }

  Player.updating(Player oldPlayer){
    this.key = oldPlayer.key;
    this.color = oldPlayer.color;
    this.startingLife = oldPlayer.startingLife;
    this.active = oldPlayer.active;
    this.key = oldPlayer.key;
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