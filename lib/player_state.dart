import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PlayerState {
    int lifepoints;
    int poison;
    int storm;
    Map<String,int> commander_damage;
    Color color;
    String key;

    PlayerState({
      this.lifepoints = 20,
      this.poison = 0,
      this.storm = 0,
      this.commander_damage = const {},
      this.color = Colors.red,
    }) {
      this.key = Uuid().v4();
    }
}