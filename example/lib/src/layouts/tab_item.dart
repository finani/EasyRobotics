import 'package:flutter/material.dart';

enum TabItem {
  home,
  maps,
  info;

  @override
  String toString() {
    switch (this) {
      case home:
        return 'Home';
      case maps:
        return 'Maps';
      case info:
        return 'Info';
      default:
        return 'Unknown Tab Item';
    }
  }

  IconData toIconData() {
    switch (this) {
      case home:
        return Icons.home;
      case maps:
        return Icons.assistant_navigation;
      case info:
        return Icons.info;
      default:
        return Icons.question_mark;
    }
  }

  MaterialColor toMaterialColor() {
    switch (this) {
      case home:
        return Colors.blue;
      case maps:
        return Colors.teal;
      case info:
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}
