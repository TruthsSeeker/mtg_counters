import 'package:flutter/material.dart';
import 'package:mtgcounters/models/player.dart';

import './contrast_color.dart';


enum CounterImages {
  heart, poison, storm, commander
}

extension CounterImagesExtension on CounterImages {
  String get assetPaths {
    switch (this) {
      case CounterImages.heart:
        return 'assets/img/heart.png';
      case CounterImages.poison:
        return 'assets/img/poison.png';
      case CounterImages.storm:
        return 'assets/img/shield-full.png';
      case CounterImages.commander:
        return 'assets/img/shield-full.png|assets/img/shield-fill.png|assets/img/shield.png';
      default:
        return null;
    }
  }

  Widget getImageWidgetFor({Player player, Color frontColor} ) {
    if (this == CounterImages.commander) {
      List<String> images = this.assetPaths.split('|');
      return Stack(
        children: <Widget>[
          // Image.asset(
          //   images[0],
          //   color: player.color.contrastingBWColor(),
          //   fit: BoxFit.scaleDown,
          // ),
          Image.asset(
            images[1],
            color: frontColor,
            fit: BoxFit.scaleDown,
          ),
          Image.asset(
            images[2],
            color: player.color.contrastingBWColor(),
            fit: BoxFit.scaleDown,
          ),
        ],
      );
    } else {
      return Image.asset(
        this.assetPaths,
        color: player.color.contrastingBWColor(),
        fit: BoxFit.scaleDown,
      );
    }
  }

}

enum DiceImages {
  one, two, three, four, five, six
}

extension DiceImagesExtension on DiceImages {
  String get assetPaths {
    switch (this) {
      case DiceImages.one:
        return 'assets/img/inverted-dice-1.png';
      case DiceImages.two:
        return 'assets/img/inverted-dice-2.png';
      case DiceImages.three:
        return 'assets/img/inverted-dice-3.png';
      case DiceImages.four:
        return 'assets/img/inverted-dice-4.png';
      case DiceImages.five:
        return 'assets/img/inverted-dice-5.png';
      case DiceImages.six:
        return 'assets/img/inverted-dice-6.png';
      default:
        return null;
    }
  }

  int get numericalValue {
    switch (this) {
      case DiceImages.one:
        return 1;
      case DiceImages.two:
        return 2;
      case DiceImages.three:
        return 3;
      case DiceImages.four:
        return 4;
      case DiceImages.five:
        return 5;
      case DiceImages.six:
        return 6;
    }
  }

  Widget getImageWidgetFor(Player player) {
    return Image.asset(
      this.assetPaths,
      color: player.color.contrastingBWColor(),
      fit: BoxFit.scaleDown,
    );
  }
}