import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/utility/image_utility.dart';

import 'inherited_player_state.dart';

class CounterMini extends StatelessWidget {
  final bool start;
  final CounterImages image;
  final Color frontColor;
  final String target;


  const CounterMini({
    Key key,
    this.image = CounterImages.heart,
    this.frontColor = Colors.black,
    this.start = false,
    this.target
  }) : super(key: key);

  Border get border {
    return Border(
      bottom: BorderSide(width: 2, color: Colors.transparent),
      left: BorderSide(width: start ? 2 : 0, color: Colors.transparent),
      right: BorderSide(width: 2, color: Colors.transparent),
    );
  }

  Widget get imageWidget {
    return ImageUtility.getImageWidgetFor(image: image, color: frontColor);
  }


  @override
  Widget build(BuildContext context) {
    var state = InheritedPlayerState.of(context);
    return Flexible(
      fit: FlexFit.loose,
      child: GestureDetector(
        onTap: () {
          state.updateTarget(target);
          state.updateImage(image);
          state.updateColor(frontColor);
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          constraints: BoxConstraints.tight(Size(60, 40)),
          decoration: BoxDecoration(
            border: border
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(state.player.props[target].toString()),
                    ),
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