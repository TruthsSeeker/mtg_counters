import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/game.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/main_page/scalable_image.dart';
import 'package:provider/provider.dart';

class _RandomizerDisplayState extends State<RandomizerDisplay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Game _game;
  late Player _player;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    );
  }

  @override
  Widget build(BuildContext context) {
    _player = Provider.of<Player>(context);
    _game = Provider.of<Game>(context);
    return ScalableImage(controller: _animationController,);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(RandomizerDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_player.index == _game.diceThrowWinner &&  _game.diceThrowStep == _game.randomValues.first.length - 1) {
      scaleUpAndDown();
    }
  }


  Future<void> scaleUpAndDown() async {
    try {
      await _animationController.forward().orCancel;
      await _animationController.reverse().orCancel;
      Timer(Duration(seconds: 1), () {
        _game.mainDisplayMode = MainDisplayMode.game;
      });
    } on TickerCanceled { }
  }

}

class RandomizerDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomizerDisplayState();

}