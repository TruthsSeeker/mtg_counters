import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:mtgcounters/widgets/main_page/bordered_text_stack.dart';
import 'package:provider/provider.dart';

class MainDisplay extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<Player>(
      builder: (context, player, _) => GestureDetector(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4,8,4,0),
                    child: BorderedTextStack(player.props[player.active].toString()),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Center(
                    child: _getIndicator(context)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getIndicator(BuildContext context) {
    Player player = Provider.of<Player>(context);
    Game game = Provider.of<Game>(context);
    Color color = player.color;
    int playerTarget = int.tryParse(player.active);
    if (playerTarget != null) {
      color = game.players[playerTarget].color;
    }
    return player.mainImage.getImageWidgetFor(player: player, frontColor: color);
  }
}