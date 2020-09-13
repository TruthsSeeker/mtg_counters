import 'package:flutter/material.dart';
import 'package:mtgcounters/utility/image_utility.dart';

class CounterImage extends StatelessWidget {
  final CounterImages image;
  final Color frontColor;
  final Color backColor;

  CounterImage({
    Key key,
    this.image,
    this.frontColor = Colors.black,
    this.backColor = Colors.blue,
  });

  Widget getImageWidgetFor() {
    if (image == CounterImages.commander) {
      List<String> images = ImageUtility.counterImage(image).split('|');
      return Stack(
        children: <Widget>[
          Image.asset(
            images[0],
            color: backColor,
            fit: BoxFit.scaleDown,
          ),
          Image.asset(
            images[1],
            color: frontColor,
            fit: BoxFit.scaleDown,
          ),
        ],
      );
    } else {
      return Image.asset(
        ImageUtility.counterImage(image),
        color: frontColor,
        fit: BoxFit.scaleDown,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getImageWidgetFor();
  }
}
