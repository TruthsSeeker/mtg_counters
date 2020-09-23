import 'package:flutter/widgets.dart';

class AppScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // TODO: implement getScrollPhysics
    return ClampingScrollPhysics();
  }
}
