import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/main_page/randomizer_display.dart';
import 'package:provider/provider.dart';

class RandomizerContainer extends StatelessWidget {
  final Player player;
  final int quarterTurns;

  RandomizerContainer(
      this.player,
      this.quarterTurns
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<Player>(
      builder: (context, player, _) => Expanded(
        flex: 1,
        child: Container(
          color: player.color,
          child: RotatedBox(
            quarterTurns: quarterTurns,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Spacer(flex: 1,),
                    Flexible(
                      flex: 19,
                      fit: FlexFit.tight,
                      child: Center(child: RandomizerDisplay()),
                    ),
                    Spacer(flex: 1,)
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
