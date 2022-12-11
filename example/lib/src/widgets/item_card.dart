import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
import 'package:easy_robotics/src/layouts/tab_navigator.dart';

Widget buildItemCard(BuildContext context,
    {required OnPush onPush,
    required String itemKey,
    required double cardWidthRatio,
    required double cardHeightRatio}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  final cardWidth = screenWidth * cardWidthRatio;
  final cardHeight = screenHeight * cardHeightRatio;

  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.all(10),
    child: Container(
      width: cardWidth,
      height: cardHeight,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: InkWell(
        onTap: () => onPush.call(
          context,
          route: TabNavigatorRoutes.filter,
          itemKey: itemKey,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(itemKey)],
          ),
        ),
      ),
    ),
  );
}
