import 'package:flutter/material.dart';
import 'package:mtgcounters/counter_button.dart';
import 'package:mtgcounters/inherited_player_state.dart';
import 'package:mtgcounters/player_state.dart';

class PlayerCountersState extends State<PlayerCounters> {
  double scale;
  int _lifepoints ,_poison ,_commanderDamage ,_counter ,_storm;
  PlayerState _playerValues = new PlayerState();

  PlayerCountersState({this.scale = 1});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildCounters();
  }



  Widget _buildCounters() {
    return InheritedPlayerState(
      data: this._playerValues,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CounterButton(),
                        CounterButton(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 14,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/heart.png"),
                              fit: BoxFit.contain),
                        ),
                        child: Center(
                          child: Text(
                            //TODO: Depend on PlayerState
                            "20",
                            style: TextStyle(
                                fontFamily: 'Merriweather',
                                fontSize: 48 * this.scale),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: <Widget>[
                        CounterButton(),
                        CounterButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image(
                      image: AssetImage("assets/img/heart.png"),
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: AssetImage("assets/img/poison.png"),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                            "assets/img/shield-full.png",
                          color: Colors.blueGrey,
                        ),
                        Image.asset(
                          "assets/img/shield.png",
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: AssetImage("assets/img/shield.png"),
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: AssetImage("assets/img/shield.png"),
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }


}


class PlayerCounters extends StatefulWidget {
  double scale;

  PlayerCounters({this.scale = 1});

  @override
  State<StatefulWidget> createState() => PlayerCountersState(scale: this.scale);
}
