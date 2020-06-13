import 'package:flutter/widgets.dart';
import 'package:mtgcounters/player_state.dart';

class InheritedPlayerState extends InheritedWidget {
  const InheritedPlayerState({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final PlayerState data;

  static InheritedPlayerState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedPlayerState>();
  }

  @override
  bool updateShouldNotify(InheritedPlayerState old) {
    print(data.lifepoints);
    return data != old.data;
  }

  update(int value) {
    this.data.lifepoints += value;
    print(this.data.lifepoints);
  }
}
