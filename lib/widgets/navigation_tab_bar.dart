import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/widgets/game.dart';
import 'package:mtgcounters/widgets/main_page/game_layout.dart';
import 'package:mtgcounters/widgets/menu/menu.dart';

class _NavigationTabBarState extends State<NavigationTabBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    GameLayout(),
    Menu()
  ];

  _NavigationTabBarState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: new ImageIcon(
                    AssetImage('assets/img/count.png')
                ),
                title: new Text('Counters')
            ),
            BottomNavigationBarItem(
                icon: new ImageIcon(
                    AssetImage('assets/img/menu.png')
                ),
                title: new Text("Menu")
            )
          ],
          onTap: onTabTapped,
        ),
        body: _children[_currentIndex]
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class NavigationTabBar extends StatefulWidget {

  NavigationTabBar();

  @override
  _NavigationTabBarState createState() => _NavigationTabBarState();
}
