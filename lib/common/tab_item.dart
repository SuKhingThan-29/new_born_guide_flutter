import 'package:chitmaymay/screen/home/bottom_nav/home_screen.dart';
import 'package:flutter/material.dart';

class TabItem {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;
  late Widget _page;
  TabItem({
    required Widget page,
  }) {
    _page = page;
  }
  void setIndex(int i) {
    _index = i;
  }

  int getIndex() => _index;

  Widget get page {
    return Visibility(
      visible: _index == HomeScreenState.selectedIndex,
      maintainState: true,
      child: Navigator(
        key: key,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (_) => _page,
          );
        },
      ),
    );
  }
}
