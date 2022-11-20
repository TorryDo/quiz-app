extension MapX<ORIGIN> on Iterable<ORIGIN> {
  List<ADAPTER> mapNotNull<ADAPTER>(ADAPTER? Function(ORIGIN) adapter) {
    List<ADAPTER> ts = [];
    for (final element in this) {
      final temp = adapter(element);
      if (temp == null) continue;
      ts.add(temp);
    }
    return ts;
  }
}
