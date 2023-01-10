import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/main_page/player_counters.dart';
import 'package:provider/provider.dart';

class PlayerCounterContainer extends StatelessWidget {
  final Player player;
  final int quarterTurns;

  PlayerCounterContainer({required this.player, required this.quarterTurns});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    List<Player> otherPlayers = game.players.where((element) => element.index != player.index).toList();
    return Flexible(
      flex: 1,
      child: Container(
        color: player.color,
        child: RotatedBox(
          quarterTurns: quarterTurns,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Spacer(flex: 1,),
                  Flexible(
                    flex: 19,
                    fit: FlexFit.tight,
                    child: PlayerCounters(player: player, commanders: otherPlayers),
                  ),
                  Spacer(flex: 1,)
                ]
            ),
          ),
        ),
      ),
    );
  }
}
