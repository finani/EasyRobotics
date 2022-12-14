enum GuidanceItem {
  pureProportionalNavigation,
  trueProportionalNavigation,
  augmentedProportionalNavigation;

  @override
  String toString() {
    switch (this) {
      case GuidanceItem.pureProportionalNavigation:
        return 'Pure Proportional Navigation';
      case GuidanceItem.trueProportionalNavigation:
        return 'True Proportional Navigation';
      case GuidanceItem.augmentedProportionalNavigation:
        return 'Augmented Proportional Navigation';
      default:
        return 'Unknown Filter Item';
    }
  }

  static List<GuidanceItem> getGuidanceItemList() {
    return [
      GuidanceItem.pureProportionalNavigation,
      GuidanceItem.trueProportionalNavigation,
      GuidanceItem.augmentedProportionalNavigation,
    ];
  }
}
