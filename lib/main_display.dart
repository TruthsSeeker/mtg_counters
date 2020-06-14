import 'package:flutter/widgets.dart';
import 'package:mtgcounters/inherited_player_state.dart';

class MainDisplay extends StatelessWidget {
  const MainDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InheritedPlayerState state = InheritedPlayerState.of(context);
    return Expanded(
      flex: 14,
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/heart.png"),
                fit: BoxFit.contain),
          ),
          child: Center(
            child: Text(
              //TODO: Depend on PlayerState
              '${state.data.props[state.data.active]}',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 48 * state.data.scale),
            ),
          ),
        ),
      ),
    );
  }
}