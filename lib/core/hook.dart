class Hook {
  var isLaunched = false;

  void runOneTime(Function f) {

    if (isLaunched) return;
    f();
    isLaunched = true;
  }
}
