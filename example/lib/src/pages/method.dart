import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
import 'package:easy_robotics/src/pages/filter/filter_item.dart';
import 'package:easy_robotics/src/pages/filter/first_order_filter.dart';
import 'package:easy_robotics/src/widgets/item_card.dart';

class Method extends StatelessWidget {
  const Method({
    super.key,
    required this.appBarColor,
    required this.route,
    required this.itemKey,
    required this.onPush,
  });

  final Color appBarColor;
  final String route;
  final dynamic itemKey;
  final OnPush onPush;

  @override
  Widget build(BuildContext context) {
    switch (itemKey) {
      case FilterItem.filter:
        return Scaffold(
          appBar: AppBar(
            title: Text("Index 00: Method ($route)"),
            backgroundColor: appBarColor,
          ),
          body: Center(
            child: buildItemCard(
              context,
              route: route,
              itemKey: FilterItem.firstOrderFilter,
              onPush: onPush,
              cardHeightRatio: 0.2,
              cardWidthRatio: 0.2,
            ),
          ),
        );
      case FilterItem.firstOrderFilter:
        return FirstOrderFilter(appBarColor: appBarColor);
      default:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Index 00: Unknown Method"),
            backgroundColor: appBarColor,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
    }
  }
}
