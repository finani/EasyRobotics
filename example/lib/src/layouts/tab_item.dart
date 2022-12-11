import 'package:flutter/material.dart';

enum TabItem {
  home,
  maps,
  info,
}

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.maps: 'Maps',
  TabItem.info: 'Info',
};

const Map<TabItem, IconData> tabIcon = {
  TabItem.home: Icons.home,
  TabItem.maps: Icons.assistant_navigation,
  TabItem.info: Icons.info,
};

const Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.home: Colors.blue,
  TabItem.maps: Colors.teal,
  TabItem.info: Colors.indigo,
};
