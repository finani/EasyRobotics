import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
import 'package:easy_robotics/src/layouts/tab_navigator_routes.dart';
import 'package:easy_robotics/src/widgets/item_card.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.appBarColor,
    required this.onPush,
  });

  final Color appBarColor;
  final OnPush onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Index 0: Home"),
        backgroundColor: appBarColor,
      ),
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 4 / 3,
        ),
        itemCount: TabNavigatorRoutes.getTabNavigatorRoutesList().length,
        itemBuilder: (context, index) {
          return buildItemCard(
            context,
            route: TabNavigatorRoutes.getTabNavigatorRoutesList()[index],
            itemKey: "",
            onPush: onPush,
            cardHeightRatio: 0.2,
            cardWidthRatio: 0.2,
          );
        },
      ),
    );
  }
}
