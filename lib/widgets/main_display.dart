import 'package:flutter/widgets.dart';
import 'package:mtgcounters/utility/image_utility.dart';
import 'package:mtgcounters/widgets/inherited_player_state.dart';

class MainDisplay extends StatelessWidget {

  final CounterImages image;
  final Color color;

  const MainDisplay({
    Key key,
    this.image,
    this.color,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    InheritedPlayerState state = InheritedPlayerState.of(context);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
//        constraints: BoxConstraints.tightFor(width: 20, height: 160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(state.player.props[state.target].toString()),
              ),
            ),

            Expanded(
              flex: 1,
              child: Center(
                  child: ImageUtility.getImageWidgetFor(image: image, color: color)
              ),
            )
          ],
        ),
      ),
    );
  }
}