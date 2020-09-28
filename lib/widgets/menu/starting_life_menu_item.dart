import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:provider/provider.dart';

import 'input_done_view.dart';

class _StartingLifeMenuItemState extends State<StartingLifeMenuItem> {
  final Map<int, Widget> defaultStartingLife = const <int, Widget>{
    20: Padding(
      padding: EdgeInsets.all(8),
      child:Text(
        '20',
        style: TextStyle(
            fontSize: 24
        ),
      ),
    ),
    25: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          '25',
          style: TextStyle(
              fontSize: 24
          ),
        )
    ),
    30: Padding(
      padding: EdgeInsets.all(8),
      child:Text(
        '30',
        style: TextStyle(
            fontSize: 24
        ),
      ),
    ),
    40: Padding(
      padding: EdgeInsets.all(8),
      child:Text(
        '40',
        style: TextStyle(
            fontSize: 24
        ),
      ),
    ),
  };

  OverlayEntry overlayEntry;

  _StartingLifeMenuItemState();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (Platform.isIOS) {
        KeyboardVisibility.onChange.listen((bool visible) {
          if (visible) {
            showOverlay(context);
          } else {
            removeOverlay(context);
          }
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    Game game = Provider.of<Game>(context);
    TextEditingController controller = TextEditingController();
    controller.text = game.startingLife.toString();
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Set starting life',
            style: TextStyle(
                fontSize: 20
            ),
          ),
          SizedBox(
            height: 60,
            child: CupertinoSegmentedControl(
              selectedColor: Colors.black,
              borderColor: Colors.black,
              children: defaultStartingLife,
              groupValue: game.startingLife,
              onValueChanged: game.setStartingLife,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text(
                'Custom starting life',
                style: TextStyle(
                    fontSize: 16
                )
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: getCustomStartingLifeCallback(game.setStartingLife),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                focusColor: Colors.black,
              ),

            ),
          )
        ],
      ),
    );
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: InputDoneView(),
      );
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay(BuildContext context) {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  ValueChanged<String> getCustomStartingLifeCallback(ValueChanged<int> statefulCallback) {
    return (String value) => {
      if (int.tryParse(value) != null) {
        statefulCallback(int.parse(value))
      }
    };
  }
}

class StartingLifeMenuItem extends StatefulWidget {
  StartingLifeMenuItem();

  @override
  _StartingLifeMenuItemState createState() => _StartingLifeMenuItemState();
}
