import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _PlayerColorSelectionMenuItemState
    extends State<PlayerColorSelectionMenuItem> {
  _PlayerColorSelectionMenuItemState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
    );
  }
}

class PlayerColorSelectionMenuItem extends StatefulWidget {
  PlayerColorSelectionMenuItem();

  @override
  _PlayerColorSelectionMenuItemState createState() =>
      _PlayerColorSelectionMenuItemState();
}
