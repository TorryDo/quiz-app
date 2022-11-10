import 'package:flutter/widgets.dart';

extension ScreenSizeX on BuildContext{
  double width() => MediaQuery.of(this).size.width;
  double height() => MediaQuery.of(this).size.height;
}