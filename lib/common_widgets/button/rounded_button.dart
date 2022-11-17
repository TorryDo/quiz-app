import 'package:flutter/material.dart';
import 'package:quiz_app/common_widgets/button/base_button_stateful_widget.dart';

class RoundedButton extends BaseButtonStatefulWidget {

  final BorderRadius? borderRadius;

  const RoundedButton({
    Key? key,
    required super.onPressed,
    required super.child,
    super.onHover,
    super.onLongPressed,
    super.backgroundColor,

    this.borderRadius
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {

  get _borderRadius => widget.borderRadius ?? BorderRadius.circular(18.0);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: _borderRadius),
        ),
        backgroundColor: MaterialStateProperty.all(widget.backgroundColor),
      ),
      onPressed: widget.onPressed,
      onLongPress: () {
        if (widget.onLongPressed != null) {
          widget.onLongPressed!();
        }
      },
      onHover: widget.onHover,
      child: widget.child,
    );
  }
}
