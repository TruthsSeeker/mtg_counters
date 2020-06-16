import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/image_utility.dart';

import 'inherited_player_state.dart';

class CounterMini extends StatelessWidget {
  final bool start;
  final CounterImages image;
  final Color frontColor;
  final Color backColor;
  final String target;


  const CounterMini({
    Key key,
    this.image = CounterImages.heart,
    this.frontColor = Colors.black,
    this.backColor,
    this.start = false,
    this.target
  }) : super(key: key);

  Border get border {
    return Border(
      bottom: BorderSide(width: 2, color: Colors.blueAccent),
      left: BorderSide(width: start ? 2 : 0, color: Colors.blueAccent),
      right: BorderSide(width: 2, color: Colors.blueAccent),
    );
  }

  Widget get imageWidget {
    return ImageUtility.getImageWidgetFor(image: image, frontColor: frontColor, backColor: backColor);
  }


  @override
  Widget build(BuildContext context) {
    var state = InheritedPlayerState.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          state.data.setActive(this.target);
          state.data.setActiveImage(image, frontColor, backColor);
        },
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
                child: imageWidget,
              )
            ],
          ),
        ),
      ),
    );
  }
}