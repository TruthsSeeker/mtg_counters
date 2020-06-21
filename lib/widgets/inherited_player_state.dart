import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';

//todo: Refactor data to use Value Callback
//todo: Refactor player state into game state
class InheritedPlayerState extends InheritedWidget {
  const InheritedPlayerState({
    Key key,
    @required this.player,
    @required this.target,
    @required this.updateValue,
    @required this.updateTarget,
    @required this.updateColor,
    @required this.updateImage,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Player player;
  final String target;

  final ValueChanged<int> updateValue;
  final ValueChanged<String> updateTarget;
  final ValueChanged<Color> updateColor;
  final ValueChanged<CounterImages> updateImage;

  static InheritedPlayerState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedPlayerState>();
  }

  @override
  bool updateShouldNotify(InheritedPlayerState old) {
    return this.player.props == old.player.props && updateValue == old.updateValue && target == old.target;
  }
}
