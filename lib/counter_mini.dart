import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'inherited_player_state.dart';

class CounterMini extends StatelessWidget {
  final int index;
  final String frontImage;
  final String backImage;
  final Color frontColor;
  final Color backColor;
  final String target;

  const CounterMini({
    Key key,
    this.frontImage = 'assets/img/heart.png',
    this.backImage,
    this.frontColor = Colors.black,
    this.backColor = Colors.white,
    this.index,
    this.target
  }) : super(key: key);

  Widget getImageWidget() {
    if (backImage == null) {
      return Image.asset(
        frontImage,
        color: frontColor,
        fit: BoxFit.scaleDown,
      );
    } else {
      return Stack(
        children: <Widget>[
          Image.asset(
            backImage,
            color: backColor,
            fit: BoxFit.scaleDown,
          ),
          Image.asset(
            frontImage,
            color: frontColor,
            fit: BoxFit.scaleDown,
          ),
        ],
      );
    }
  }

  Border get border {
    return Border(
      bottom: BorderSide(width: 2, color: Colors.blueAccent),
      left: BorderSide(width: index == 0 ? 2 : 0, color: Colors.blueAccent),
      right: BorderSide(width: 2, color: Colors.blueAccent),
    );
  }


  @override
  Widget build(BuildContext context) {
    var state = InheritedPlayerState.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => state.data.setActive(this.target),
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          constraints: BoxConstraints.tightFor(width: 40, height: 40),
          decoration: BoxDecoration(
            border: border
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(state.data.props[target].toString()),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: getImageWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}