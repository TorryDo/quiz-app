import 'package:flutter/material.dart';

abstract class BaseButtonStatefulWidget extends StatefulWidget {
  final Function() onPressed;
  final Function()? onLongPressed;
  final Function(bool)? onHover;
  final Widget child;

  final Color backgroundColor;

  const BaseButtonStatefulWidget({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.blueAccent,
    this.onHover,
    this.onLongPressed,
  }) : super(key: key);
}
