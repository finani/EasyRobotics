enum FilterItem {
  lowPassFilter,
  highPassFilter,
  secondOrderFilter;

  @override
  String toString() {
    switch (this) {
      case FilterItem.lowPassFilter:
        return 'Low Pass Filter';
      case FilterItem.highPassFilter:
        return 'High Pass Filter';
      case FilterItem.secondOrderFilter:
        return 'Second Order Filter';
      default:
        return 'Unknown Filter Item';
    }
  }

  static List<FilterItem> getFilterItemList() {
    return [
      FilterItem.lowPassFilter,
      FilterItem.highPassFilter,
      FilterItem.secondOrderFilter,
    ];
  }
}
