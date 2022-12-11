class TabNavigatorRoutes {
  static const String root = '/';
  static const String filter = '/filter';
  static const String guidance = '/guidance';

  static List<String> getTabNavigatorRoutesList() {
    return [
      TabNavigatorRoutes.filter,
      TabNavigatorRoutes.guidance,
    ];
  }
}
