import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/main_page/player_counters.dart';

class PlayerCounterContainer extends StatelessWidget {
  final Player player;
  final int quarterTurns;

  PlayerCounterContainer({this.player, this.quarterTurns});

  @override
  Widget build(BuildContext context) {
    InheritedGameState state = InheritedGameState.of(context);
    List<Player> otherPlayers = state.playerStates.values.toList();
    otherPlayers.remove(player);
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
                    child: PlayerCounters(player, otherPlayers, state.playerChanged),
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
