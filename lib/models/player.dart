import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:mtgcounters/utility/image_utility.dart';

class Player with ChangeNotifier{
  int startingLife;
  int index;
  Color color;
  String active;
  CounterImages mainImage = CounterImages.heart;
  Timer? _timer;
  int _currentChange = 0;
  Map<String, int> _props = {};
  Map<String, int> get props {
    return _props;
  }
  set props(Map<String, int> props) {
    _props = props;
    notifyListeners();
  }

  Player({
      required this.index,
      required this.color,
      required this.startingLife,
      this.active = 'lifepoints'}) {
    this.props = {'lifepoints': startingLife, 'poison':  0, 'storm': 0};
  }

  reset() {
    this.props.updateAll((k, v) {
      if (k == 'lifepoints') {
        return startingLife;
      }
      return 0;
    });
    changeActive('lifepoints');
    notifyListeners();
  }

  changeActive(String target) {
    this.active = target;

    notifyListeners();
  }

  setActiveImage(CounterImages image) {
    this.mainImage = image;
    notifyListeners();
  }

  update(int value) {
    int oldValue = this.props[active] ?? 0;
    int newValue = value + oldValue;
    this.props[active] = newValue;
    notifyListeners();
  }

  setColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  touchStarted(int value) {
    update(value);
    Duration period = getTimerPeriod();
    _timer = Timer.periodic(period, (timer) {
      _currentChange += value;
      update(value);
      if (getTimerPeriod().inMilliseconds != period.inMilliseconds) {
        timer.cancel();
        touchStarted(value);
      }
    });
  }

  Duration getTimerPeriod() {
    if (_currentChange.abs() < 5) {
      return Duration(milliseconds: 250);
    } else if (_currentChange.abs() < 15) {
      return Duration(milliseconds: 150);
    } else {
      return Duration(milliseconds: 75);
    }
  }

  endUpdate() {
    _timer?.cancel();
    _currentChange = 0;
  }
}