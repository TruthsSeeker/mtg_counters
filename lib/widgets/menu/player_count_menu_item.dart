import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:provider/provider.dart';

class PlayerCountMenuItem extends StatelessWidget {
  final Map<int, Widget> playerCounts = const <int, Widget> {
    2:Text('2'),
    3:Text('3'),
    4:Text('4'),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder:(context, game, _) => Padding(
        padding: const EdgeInsets.fromLTRB(8,0,8,0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                  "Number of players",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              Expanded(
                child: CupertinoSegmentedControl<int>(
                  selectedColor: game.mainDisplayMode == MainDisplayMode.game ? Colors.black : Colors.grey,
                  borderColor: game.mainDisplayMode == MainDisplayMode.game ? Colors.black : Colors.grey,
                  children: playerCounts,
                  onValueChanged: game.mainDisplayMode == MainDisplayMode.game ? game.updatePlayerCount : (int) {},
                  groupValue: game.players.length,

                ),
              )
            ],
        ),
      ),
    );
  }
}
