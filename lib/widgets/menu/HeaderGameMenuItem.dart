import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/widgets/menu/confirm_reset.dart';
import 'package:provider/provider.dart';

class HeaderGameMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, _) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: game.throwDice,
            child: Container(
              child: Icon(Icons.casino, size: 40,),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
          ),
          GestureDetector(
            onTap: () =>
            {
              if (game.confirmReset) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmReset();
                  })
              } else {
                game.restartGame()
              }
            },
            child: Container(
                child: Icon(Icons.refresh, size: 40,),
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
          )
        ],
      ),
    );
  }
}
