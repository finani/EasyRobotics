import 'package:easy_robotics/src/pages/filter/first_order_filter.dart';
import 'package:flutter/material.dart';

class Filter extends StatelessWidget {
  const Filter({
    super.key,
    required this.itemKey,
    required this.appBarColor,
  });

  final String itemKey;
  final Color appBarColor;

  @override
  Widget build(BuildContext context) {
    switch (itemKey) {
      case "FirstOrderFilter":
        return FirstOrderFilter(appBarColor: appBarColor);
      default:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Index 00: Filter"),
            backgroundColor: appBarColor,
          ),
        );
    }
  }
}
