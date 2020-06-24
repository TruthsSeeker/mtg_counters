import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';

class InheritedGameState extends InheritedWidget {
  const InheritedGameState({
    Key key,
    @required this.playerStates,
    @required this.playerChanged,
    @required this.restart,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Map<String, Player> playerStates;
  final ValueChanged<Player> playerChanged;
  final Function restart;

  static InheritedGameState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedGameState>();
  }

  @override
  bool updateShouldNotify(InheritedGameState old) {
    bool notify = false;
    playerStates.forEach((k, v) => notify = v.props != old.playerStates[k].props);

    return notify || playerChanged != old.playerChanged;
  }
}
