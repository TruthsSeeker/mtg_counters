import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _MenuBarState extends State<MenuBar> {
  _MenuBarState();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
    );
  }
}

class MenuBar extends StatefulWidget {
  MenuBar();

  @override
  _MenuBarState createState() => _MenuBarState();
}