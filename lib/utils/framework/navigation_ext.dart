import 'package:flutter/cupertino.dart';

extension NavigationX on BuildContext {
  Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
      String routeName, {
        TO? result,
        Object? arguments,
      }) {
    return Navigator.of(this).popAndPushNamed<T, TO>(routeName, arguments: arguments, result: result);
  }
}
