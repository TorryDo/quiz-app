import 'package:flutter/material.dart';

class ScreenBackground {
  final Color? color;
  final String? backgroundSrc;

  const ScreenBackground.color(this.color, {this.backgroundSrc});

  const ScreenBackground.asset(this.backgroundSrc, {this.color});

  get value {
    if (color != null) return color!;
    if (backgroundSrc != null) return backgroundSrc!;
    throw Exception("screenBackground not provided");
  }
}

class BaseScreen extends StatefulWidget {
  final Widget child;
  final Color? color;
  final String? backgroundAsset;
  final Widget? background;

  const BaseScreen({
    Key? key,
    required this.child,
    this.color,
    this.backgroundAsset,
    this.background,
  }) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    // if (widget.color != null && widget.backgroundAsset != null ) {
    //   throw Exception(
    //       "passing only color or backgroundAssets, one of them must be null");
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color,
      child: Stack(children: [
        () {
          if (widget.backgroundAsset != null) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                widget.backgroundAsset!,
                fit: BoxFit.cover,
              ),
            );
          }
          return const SizedBox();
        }(),
            () {
          if (widget.background != null) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: widget.background,
            );
          }
          return const SizedBox();
        }(),
        widget.child,
      ]),
    );
  }
}
