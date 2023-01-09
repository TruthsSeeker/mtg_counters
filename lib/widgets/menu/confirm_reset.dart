import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../models/game.dart';

class _ConfirmResetState extends State<ConfirmReset> {
  bool _disablePopUp = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(16),
            child: Text("Are you sure you want to reset the game?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          TextButton(
              onPressed: () {
                Game game = Provider.of<Game>(context, listen: false);
                game.setResetConfirmDisplay(false);
                game.restartGame();
                Navigator.of(context).pop();
              },
              child: Text("Yes, don't show this again")
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Game game = Provider.of<Game>(context, listen: false);
                    game.setResetConfirmDisplay(true);
                    Navigator.of(context).pop();
                  },
                  child: Text("No",
                    style: TextStyle(
                        color: Colors.redAccent
                    )
                  )),
              SizedBox(
                height: 48,
                child: VerticalDivider(

                  thickness: 1,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Game game = Provider.of<Game>(context, listen: false);
                    game.setResetConfirmDisplay(true);
                    game.restartGame();
                    Navigator.of(context).pop();
                  },
                  child: Text("Yes")
              ),
            ],
          ),
          SizedBox(height: 2,)
        ],
      ),
    );
    // return AlertDialog(
    //   title: const Text("Are you sure you want to reset the game?"),
    //   content: const Text("You can choose to disable or enable this pop-up in the options sheet"),
    //   actions: [
    //     Row(
    //       children: [
    //         Checkbox(
    //             value: _disablePopUp,
    //             onChanged: (bool value) => {
    //               setState(() {
    //                 _disablePopUp = value;
    //               })
    //             },
    //             ),
    //         Expanded(
    //           child: Text("Don't show this again",
    //               style: TextStyle(
    //                 fontSize: 10,
    //               )
    //           ),
    //         ),
    //         TextButton(
    //             onPressed: () {
    //               Game game = Provider.of<Game>(context, listen: false);
    //               game.setResetConfirmDisplay(!_disablePopUp);
    //               Navigator.of(context).pop();
    //             },
    //             child: Text("No")),
    //         TextButton(
    //             onPressed: () {
    //               Game game = Provider.of<Game>(context, listen: false);
    //               game.setResetConfirmDisplay(!_disablePopUp);
    //               game.restartGame();
    //               Navigator.of(context).pop();
    //             },
    //             child: Text("Yes"))
    //       ],
    //     ),
    //   ],
    // );
  }
}

class ConfirmReset extends StatefulWidget {
  // ConfirmReset();

  @override
  _ConfirmResetState createState() => _ConfirmResetState();
}
