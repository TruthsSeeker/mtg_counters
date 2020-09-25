import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:provider/provider.dart';

class ResetGameMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Game>(
      builder: (context, game, _) => GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                child: Text(
                  'Reset game',
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
            ),
            Container(
                child: Icon(Icons.refresh, size: 40,),
                padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
            )
          ],
        ),
        onTap: game.throwDice,
      ),
    );
  }
}
