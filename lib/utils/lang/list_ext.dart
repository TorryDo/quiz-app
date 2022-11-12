extension ListX<T> on List<T> {
  /// clear();
  ///
  /// addAll(items);
  void clearAdd(Iterable<T> iterable) {
    clear();
    addAll(iterable);
  }
}
