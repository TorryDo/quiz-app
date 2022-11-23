import 'dart:async';

import 'package:flutter/material.dart';

class CountDownView extends StatefulWidget {
  final double? width;
  final double? height;
  final Decoration? decoration;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Duration countdown;
  final TextStyle textStyle;

  final Function? onFinished;

  const CountDownView({
    Key? key,
    this.width,
    this.height,
    this.decoration,
    this.leadingIcon,
    this.trailingIcon,
    required this.countdown,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.onFinished,
  }) : super(key: key);

  @override
  State<CountDownView> createState() => _CountDownViewState();
}

class _CountDownViewState extends State<CountDownView> {
  late Timer _timer;
  int _start = 0;

  void startTimer() {
    _start = widget.countdown.inSeconds;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            if(widget.onFinished != null){
              widget.onFinished!();
            }

          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String secsToStringFormat(int secs) {
    if (secs < 60) {
      return '0:$secs';
    }
    int mins = secs ~/ 60;
    int remainedSecs = secs % 60;

    return '$mins:$remainedSecs';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(widget.leadingIcon),
          Text(secsToStringFormat(_start), style: widget.textStyle),
          Icon(widget.trailingIcon)
        ],
      ),
    );
  }
}
