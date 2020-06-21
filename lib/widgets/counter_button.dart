import 'package:flutter/widgets.dart';

import 'inherited_player_state.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    Key key,
    this.value = 1,
    this.image = 'assets/img/-5.png',
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
          state.updateValue(this.value);
        },
      ),
    );
  }
}
