enum FilterItem {
  firstOrderFilter,
  secondOrderFilter;

  @override
  String toString() {
    switch (this) {
      case FilterItem.firstOrderFilter:
        return 'First Order Filter';
      case FilterItem.secondOrderFilter:
        return 'Second Order Filter';
      default:
        return 'Unknown Filter Item';
    }
  }

  static List<FilterItem> getFilterItemList() {
    return [
      FilterItem.firstOrderFilter,
      FilterItem.secondOrderFilter,
    ];
  }
}
