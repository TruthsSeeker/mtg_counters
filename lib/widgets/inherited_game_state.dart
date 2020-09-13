import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';

class InheritedGameState extends InheritedWidget {
  const InheritedGameState({
    Key key,
    @required this.playerStates,
    @required this.startingLife,
    @required this.playerChanged,
    @required this.restart,
    @required this.playerCountChanged,
    @required this.startingLifeChanged,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Map<String, Player> playerStates;
  final int startingLife;
  final ValueChanged<Player> playerChanged;
  final Function restart;
  final ValueChanged<int> playerCountChanged;
  final ValueChanged<int> startingLifeChanged;

  static InheritedGameState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedGameState>();
  }

  @override
  bool updateShouldNotify(InheritedGameState old) {
    bool notify = false;
    playerStates.forEach((k, v) => {
      if (old.playerStates[k] != null) {
        notify = v.props != old.playerStates[k].props
      } else {
        notify = true
      }
    });

    return notify || playerChanged != old.playerChanged;
  }
}
