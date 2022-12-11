import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
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
