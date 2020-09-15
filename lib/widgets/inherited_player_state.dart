import 'package:flutter/widgets.dart';
import 'package:mtgcounters/models/player.dart';
import 'package:mtgcounters/utility/image_utility.dart';

//todo: Refactor player state into game state
class InheritedPlayerState extends InheritedWidget {
  const InheritedPlayerState({
    Key key,
    @required this.player,
    @required this.target,
    @required this.onTapDown,
    @required this.onTapUp,
    @required this.updateTarget,
    @required this.updateColor,
    @required this.updateImage,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Player player;
  final String target;
  final ValueChanged<int> onTapDown;
  final Function onTapUp;
  final ValueChanged<String> updateTarget;
  final ValueChanged<Color> updateColor;
  final ValueChanged<CounterImages> updateImage;

  static InheritedPlayerState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedPlayerState>();
  }

  @override
  bool updateShouldNotify(InheritedPlayerState old) {
    return this.player.props == old.player.props
        && onTapDown == old.onTapDown
        && onTapUp == old.onTapUp
        && target == old.target;
  }
}
