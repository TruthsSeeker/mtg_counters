import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:provider/provider.dart';

class ScalableImage extends AnimatedWidget {
  const ScalableImage({Key key, AnimationController controller})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return Consumer2<Game, Player>(
        builder:(context, game, player, _) {
          return Transform.scale(
              scale: _getScale(player, game),
              child: game
                  .randomValues[player.index][game.diceThrowStep]
                  .getImageWidgetFor(player),
          );
        }
    );
  }

  double _getScale(Player player, Game game) {
    if (player.index == game.diceThrowWinner) {
      return 1 + 0.2 * _progress.value;
    } else {
      return 1;
    }
  }
}
