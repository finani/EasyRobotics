import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
import 'package:easy_robotics/src/layouts/tab_navigator_routes.dart';
import 'package:easy_robotics/src/pages/filter/filter_item.dart';
import 'package:easy_robotics/src/pages/filter/high_pass_filter.dart';
import 'package:easy_robotics/src/pages/filter/low_pass_filter.dart';
import 'package:easy_robotics/src/pages/guidance/guidance_item.dart';
import 'package:easy_robotics/src/pages/guidance/pure_proportional_navigation.dart';
import 'package:easy_robotics/src/widgets/item_card.dart';

class Methods extends StatelessWidget {
  const Methods({
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
      case FilterItem.lowPassFilter:
        return LowPassFilter(appBarColor: appBarColor);
      case FilterItem.highPassFilter:
        return HighPassFilter(appBarColor: appBarColor);
      case FilterItem.secondOrderFilter:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Index 03: Second Order Filter"),
            backgroundColor: appBarColor,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      case GuidanceItem.pureProportionalNavigation:
        return PureProportionalNavigation(appBarColor: appBarColor);
      case GuidanceItem.trueProportionalNavigation:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Index 12: True Proportional Navigation"),
            backgroundColor: appBarColor,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      case GuidanceItem.augmentedProportionalNavigation:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Index 13: Augmented Proportional Navigation"),
            backgroundColor: appBarColor,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      default:
        switch (route) {
          case TabNavigatorRoutes.filter:
            return Scaffold(
              appBar: AppBar(
                title: Text("Index 00: Methods ($route)"),
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
                itemCount: FilterItem.getFilterItemList().length,
                itemBuilder: (context, index) {
                  return buildItemCard(
                    context,
                    route: route,
                    itemKey: FilterItem.getFilterItemList()[index],
                    onPush: onPush,
                    cardHeightRatio: 0.2,
                    cardWidthRatio: 0.2,
                  );
                },
              ),
            );
          case TabNavigatorRoutes.guidance:
            return Scaffold(
              appBar: AppBar(
                title: Text("Index 10: Methods ($route)"),
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
                itemCount: GuidanceItem.getGuidanceItemList().length,
                itemBuilder: (context, index) {
                  return buildItemCard(
                    context,
                    route: route,
                    itemKey: GuidanceItem.getGuidanceItemList()[index],
                    onPush: onPush,
                    cardHeightRatio: 0.2,
                    cardWidthRatio: 0.2,
                  );
                },
              ),
            );
          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Index --: Unknown Methods"),
                backgroundColor: appBarColor,
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
    }
  }
}
