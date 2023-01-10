import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/widgets/main_page/bordered_text_stack.dart';
import 'package:provider/provider.dart';


class CounterButton extends StatelessWidget {
  const CounterButton({
    Key? key,
    this.value = 1,
    this.image = 'assets/img/-5.png',
  }) : super(key: key);

  final String image;
  final int value;

  @override
  Widget build(BuildContext context) {

    return Consumer<Player>(
      builder: (context, player, _) => Expanded(
        child: FittedBox(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: BorderedTextStack(value >= 0 ? '+' : '-', 0.5),
            onTapDown: (details) {
              player.touchStarted(this.value);
            },
            onTapUp: (details) {
              player.endUpdate();
            },
            onTapCancel: () {
              player.endUpdate();
            },
          ),
        ),
      ),
    );
  }
}
