import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/widgets/inherited_game_state.dart';

class PlayerCountMenuItem extends StatelessWidget {
  final Map<int, Widget> playerCounts = const <int, Widget> {
    2:Text('2'),
    3:Text('3'),
    4:Text('4'),
  };

  @override
  Widget build(BuildContext context) {
    InheritedGameState gameState = InheritedGameState.of(context);
    return Row(
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
              selectedColor: Colors.black,
              borderColor: Colors.black,
              children: playerCounts,
              onValueChanged: gameState.playerCountChanged,
              groupValue: gameState.playerStates.length,

            ),
          )
        ],
    );
  }
}
