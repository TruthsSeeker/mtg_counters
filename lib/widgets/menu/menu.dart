import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mtgcounters/utility/app_scroll_behavior.dart';
import 'package:mtgcounters/widgets/menu/HeaderGameMenuItem.dart';
import 'package:mtgcounters/widgets/menu/delegates/sheet_persistent_header_delegate.dart';
import 'package:mtgcounters/widgets/menu/player_count_menu_item.dart';
import 'package:mtgcounters/widgets/menu/starting_life_menu_item.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
        minChildSize: _getMinimalSize(context),
        maxChildSize: 0.50,
        initialChildSize: _getMinimalSize(context),
        builder: (BuildContext context, ScrollController scrollController) {
          return ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfbf7f5ff),
                    borderRadius: new BorderRadius.only(
                        topLeft:  const  Radius.circular(16.0),
                        topRight: const  Radius.circular(16.0))
                ),
                child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: SheetPersistentHeaderDelegate(
                            minHeight: 10,
                            maxHeight: 10,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                                  constraints: BoxConstraints(
                                    maxHeight: 10,
                                    maxWidth: 20,
                                  ),
                                  child: Image.asset('assets/img/rounded-line.png'),
                                ),
                              ],
                            )
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                            [
                              Divider(color: Colors.grey,),
                              HeaderGameMenuItem(),
                              Divider(color: Colors.grey,),
                              PlayerCountMenuItem(),
                              Divider(color: Colors.grey,),
                              StartingLifeMenuItem(),
                            ]
                        ),
                      )

                      // ListView.separated(
                      //   controller: scrollController,
                      //   itemCount: elementList.length,
                      //   itemBuilder: (BuildContext context, int index) => elementList[index],
                      //   separatorBuilder: (BuildContext context, int index) => const Divider(),
                      // ),
                    ]
                ),
              ),
            ),
          );
        }
    );
  }

  double _getMinimalSize(BuildContext context) {
    // Divider == 16.0, drag line == 10, HeaderGameMenuItem == 40 => 66.0
    double persistentWidgetHeight = 66.0;
    double safeAreaHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom;
    return persistentWidgetHeight/safeAreaHeight;
  }
}
