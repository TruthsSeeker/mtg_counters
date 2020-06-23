import 'package:flutter/material.dart';

enum CounterImages {
  heart, poison, storm, commander
}

class ImageUtility {
  static String counterImage(CounterImages image) {
    String value;
    switch (image) {
      case CounterImages.heart:
        value = 'assets/img/heart.png';
        break;
      case CounterImages.poison:
        value = 'assets/img/poison.png';
        break;
      case CounterImages.storm:
        value = 'assets/img/shield-full.png';
        break;
      case CounterImages.commander:
        value = 'assets/img/shield-full.png|assets/img/shield.png';
        break;
    }
    return value;
  }


  static Widget getImageWidgetFor({CounterImages image, Color color = Colors.blueGrey} ) {
    if (image == CounterImages.commander) {
      List<String> images = ImageUtility.counterImage(image).split('|');
      return Stack(
        children: <Widget>[
          Image.asset(
            images[0],
            color: color,
            fit: BoxFit.scaleDown,
          ),
          Image.asset(
            images[1],
            color: Colors.black87,
            fit: BoxFit.scaleDown,
          ),
        ],
      );
    } else {
      return Image.asset(
        ImageUtility.counterImage(image),
        color: color,
        fit: BoxFit.scaleDown,
      );
    }
  }
}