mixin SideEffectNotifier<T> {
  Function(T)? handleSideEffect;

  void postSideEffect(T newEffect) {
    if (handleSideEffect != null) {
      handleSideEffect!(newEffect);
    }
  }

  void collectSideEffect(Function(T effect) doEffect) {
    handleSideEffect = doEffect;
  }
}
