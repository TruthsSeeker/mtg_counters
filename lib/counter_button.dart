import 'package:flutter/widgets.dart';
import 'package:mtgcounters/player_state.dart';
import 'inherited_player_state.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    Key key,
    this.image = 'assets/img/-5.png',
    this.value = 1,
  }) : super(key: key);

  final String image;
  final int value;

  @override
  Widget build(BuildContext context) {
    final InheritedPlayerState state = InheritedPlayerState.of(context);
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Center(
            child: Image(
          image: AssetImage(this.image),
        )),
        onTap: () {
          state.update(this.value);
        },

      ),
    );
  }
}
