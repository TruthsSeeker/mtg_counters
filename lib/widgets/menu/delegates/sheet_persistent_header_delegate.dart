import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../reset_game_menu_item.dart';

class SheetPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  SheetPersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SheetPersistentHeaderDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
            constraints: BoxConstraints(
              maxHeight: 10,
              maxWidth: 20,
            ),
            child: Image.asset('assets/img/rounded-line.png'),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          ResetGameMenuItem()
        ],
      );
  }
}
