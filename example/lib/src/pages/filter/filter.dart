import 'package:easy_robotics/src/pages/filter/first_order_filter.dart';
import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
import 'package:easy_robotics/src/widgets/item_card.dart';

class Filter extends StatelessWidget {
  const Filter({
    super.key,
    required this.itemKey,
    required this.appBarColor,
    required this.onPush,
  });

  final String itemKey;
  final Color appBarColor;
  final OnPush onPush;

  @override
  Widget build(BuildContext context) {
    switch (itemKey) {
      case "FirstOrderFilter":
        return FirstOrderFilter(appBarColor: appBarColor);
      case "Filter":
      default:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Index 00: Filter"),
            backgroundColor: appBarColor,
          ),
          body: Center(
            child: buildItemCard(
              context,
              onPush: onPush,
              itemKey: "FirstOrderFilter",
              cardHeightRatio: 0.2,
              cardWidthRatio: 0.2,
            ),
          ),
        );
    }
  }
}
