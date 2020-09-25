import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:provider/provider.dart';

class RandomizerDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Consumer2<Game, Player>(
        builder:(context, game, player, _) => game
            .randomValues[player.index]
            .last
            .getImageWidgetFor(player)
    );
  }
}
