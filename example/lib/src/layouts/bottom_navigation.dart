import 'package:flutter/material.dart';

import 'package:easy_robotics/src/layouts/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.home),
        _buildItem(TabItem.maps),
        _buildItem(TabItem.info),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: currentTab.toMaterialColor(),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        tabItem.toIconData(),
        color: _colorTabMatching(tabItem),
      ),
      label: tabItem.toString(),
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? item.toMaterialColor() : Colors.grey;
  }
}
