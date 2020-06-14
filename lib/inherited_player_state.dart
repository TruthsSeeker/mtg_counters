import 'package:flutter/widgets.dart';
import 'package:mtgcounters/player_counters.dart';

class InheritedPlayerState extends InheritedWidget {
  const InheritedPlayerState({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final PlayerCountersState data;

  static InheritedPlayerState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedPlayerState>();
  }

  @override
  bool updateShouldNotify(InheritedPlayerState old) {
    return this.data.props == old.data.props;
  }
}
