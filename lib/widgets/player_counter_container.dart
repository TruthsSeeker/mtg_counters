import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';
import 'package:mtgcounters/widgets/player_counters.dart';

class PlayerCounterContainer extends StatelessWidget {
  Player player;

  PlayerCounterContainer({this.player});

  @override
  Widget build(BuildContext context) {
    InheritedGameState state = InheritedGameState.of(context);
    List<Player> otherPlayers = state.playerStates.values.toList();
    otherPlayers.remove(player);
    return Flexible(
      flex: 1,
      child: RotatedBox(
        quarterTurns: 1,
        child: Row(
            children: <Widget>[
              Spacer(flex: 1,),
              Flexible(
                flex: 9,
                fit: FlexFit.tight,
                child: PlayerCounters(player, otherPlayers, state.playerChanged),
              ),
              Spacer(flex: 1,)
            ]
        ),
      ),
    );
  }
}
