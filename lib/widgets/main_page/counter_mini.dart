import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:provider/provider.dart';

import '../../utility/contrast_color.dart';


class CounterMini extends StatelessWidget {
  final bool start;
  final CounterImages image;
  final Color frontColor;
  final String target;


  const CounterMini({
    this.image = CounterImages.heart,
    this.frontColor = Colors.black,
    this.start = false,
    this.target
  });

  Border get border {
    return Border(
      bottom: BorderSide(width: 2, color: Colors.transparent),
      left: BorderSide(width: start ? 2 : 0, color: Colors.transparent),
      right: BorderSide(width: 2, color: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<Player>(
      builder: (context, player, _) => Flexible(
        fit: FlexFit.loose,
        child: GestureDetector(
          onTap: () {
            player.changeActive(target);
            player.setActiveImage(image);
          },
          child: Container(
            // padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
            constraints: BoxConstraints.tight(Size(60, 50)),
            decoration: BoxDecoration(
              border: border
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: image.getImageWidgetFor(player: player, frontColor: frontColor),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            player.props[target].toString(),
                            style: TextStyle(
                              color: player.color.contrastingBWColor(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}