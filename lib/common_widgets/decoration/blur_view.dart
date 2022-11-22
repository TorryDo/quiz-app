import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/src/constants/tints.dart';

class BlurView extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;

  final double sigmaX;
  final double sigmaY;
  final double opacity;

  final Color blurColor;
  final BorderRadius borderRadius;

  const BlurView(
      {Key? key,
      required this.child,
      this.width,
      this.height,
      this.borderRadius = BorderRadius.zero,
      this.sigmaX = 5.0,
      this.sigmaY = 5.0,
      this.blurColor = Colors.white,
      this.opacity = 0.3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: borderRadius,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
              child: Container(
                //you can change opacity with color here(I used black) for background.
                decoration: BoxDecoration(
                  color: blurColor.withOpacity(opacity),
                ),
              ),
            ),
          ),
          Container(child: child)
        ],
      ),
    );
  }
}
