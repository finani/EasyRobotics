import 'package:flutter/material.dart';

import 'package:easy_robotics/src/pages/home.dart';
import 'package:easy_robotics/src/pages/maps.dart';
import 'package:easy_robotics/src/pages/info.dart';
import 'package:easy_robotics/src/layouts/tab_item.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    super.key,
    required this.navigatorKey,
    required this.tabItem,
  });

  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(
      context,
      key: "",
    );

    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {required String key}) {
    Color appBarColor = activeTabColor[tabItem] ?? Colors.grey;
    switch (tabItem) {
      case TabItem.home:
        return {
          TabNavigatorRoutes.root: (context) => Home(
                appBarColor: appBarColor,
                onPush: _push,
              ),
        };
      case TabItem.maps:
        return {
          TabNavigatorRoutes.root: (context) => Maps(
                appBarColor: appBarColor,
              ),
        };
      case TabItem.info:
        return {
          TabNavigatorRoutes.root: (context) => Info(
                appBarColor: appBarColor,
              ),
        };
      default:
        return {
          TabNavigatorRoutes.root: (context) =>
              const Center(child: Text("Index NaN: Default\n/")),
        };
    }
  }

  void _push(BuildContext context,
      {required String route, required String key}) {
    final routeBuilders = _routeBuilders(
      context,
      key: key,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[route]!(context),
      ),
    );
  }
}
