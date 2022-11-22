import 'package:flutter/material.dart';

class DynamicWave extends StatefulWidget {
  final double? width;
  final double? height;

  final Color? color;
  final Gradient? gradient;

  const DynamicWave({
    Key? key,
    this.width,
    this.height,
    this.color,
    this.gradient,
  }) : super(key: key);

  @override
  State<DynamicWave> createState() => _DynamicWaveState();
}

class _DynamicWaveState extends State<DynamicWave> {
  double get DEFAULT_WIDTH => double.infinity;

  double get DEFAULT_HEIGHT => 200;

  void _checkIsValid() {
    if (widget.color != null && widget.gradient != null) {
      throw Exception(
        'can not pass both color & gradient, one of those must be null',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkIsValid();
    return CustomPaint(
      size: Size(
        widget.width ?? DEFAULT_WIDTH,
        widget.height ?? DEFAULT_HEIGHT,
      ),
      painter:
          _WaveCustomPainter(color: widget.color, gradient: widget.gradient),
    );
  }
}

class _WaveCustomPainter extends CustomPainter {
  // only 1 of 2 not null
  final Color? color;
  final Gradient? gradient;

  _WaveCustomPainter({this.color, this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    const double topLeft_X = 0;
    const double topLeft_Y = 0;
    final double topRight_X = size.width;
    const double topRight_Y = 0;
    final double bottomRight_X = size.width;
    final double bottomRight_Y = size.height;
    const double bottomLeft_X = 0;
    final double bottomLeft_Y = size.height;

    final double rightCenter_X = size.width;
    final double rightCenter_Y = size.height / 2;

    Paint paint = Paint();
    if (color != null) {
      paint.style = PaintingStyle.fill;
      paint.color = color!;
    } else if (gradient != null) {
      paint.shader = gradient!.createShader(Offset.zero & size);
    }

    Path path = Path()
      ..moveTo(topLeft_X, topLeft_Y)
      ..lineTo(topRight_X, topRight_Y)
      ..lineTo(rightCenter_X, rightCenter_Y)
      ..quadraticBezierTo(
        bottomRight_X - 150,
        bottomRight_Y + 50,
        bottomLeft_X,
        bottomLeft_Y,
      );

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
