import 'dart:developer';

import 'const.dart';


mixin Logger {
  String? _tagName;
  bool? _isLoggerEnabled;

  // getter & setter -----------------------------------------------------------

  String get tag {
    _tagName ??= _getDefaultTag();
    return _tagName!;
  }

  set setTagName(String tagName) {
    _tagName = tagName;
  }

  bool get isLoggerEnabled {
    _isLoggerEnabled ??= Const.IS_DEBUG_ENABLED;
    return _isLoggerEnabled!;
  }

  set enableLogger(bool enabled) {
    _isLoggerEnabled = enabled;
  }

  // public --------------------------------------------------------------------

  void d(String message) {
    if (isLoggerEnabled) log("<> D-$tag: $message");
  }

  void e(String message) {
    if (isLoggerEnabled) log("<> E-$tag: $message");
  }

  // private -------------------------------------------------------------------

  String _getDefaultTag() => runtimeType.toString();
}
