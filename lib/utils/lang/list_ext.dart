extension ListX<T> on List<T> {
  /// clear();
  ///
  /// addAll(items);
  void clearAdd(Iterable<T> iterable) {
    clear();
    addAll(iterable);
  }

  List<E> mapIndexed<E>(E Function(T, int) adapter) {
    List<E> rs = [];
    for (var i = 0; i < length; i++) {
      rs.add(adapter(this[i], i));
    }
    return rs;
  }
  List<E> mapTo<E>(E Function(T) adapter) {
    List<E> rs = [];
    for (var i = 0; i < length; i++) {
      rs.add(adapter(this[i]));
    }
    return rs;
  }
}
