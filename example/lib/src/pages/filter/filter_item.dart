enum FilterItem {
  filter,
  firstOrderFilter;

  @override
  String toString() {
    switch (this) {
      case FilterItem.filter:
        return 'Filter';
      case FilterItem.firstOrderFilter:
        return 'First Order Filter';
      default:
        return 'Unknown Filter Item';
    }
  }
}
