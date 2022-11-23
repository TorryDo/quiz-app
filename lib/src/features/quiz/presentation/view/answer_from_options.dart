import 'package:flutter/material.dart';
import 'package:quiz_app/common_widgets/button/rounded_button.dart';
import 'package:quiz_app/src/constants/dimens.dart';

import '../../../../../core/hook.dart';
import '../../../../../utils/logger.dart';

class AnswerFromOptionsView extends StatefulWidget {
  final List<String> options;
  final Function(int)? onOptionClick;
  final Function? onConfirmClick;
  final int previousUserAnswer;

  const AnswerFromOptionsView(
      {Key? key,
      required this.options,
      this.onOptionClick,
      this.onConfirmClick,
      required this.previousUserAnswer})
      : super(key: key);

  @override
  State<AnswerFromOptionsView> createState() => _AnswerFromOptionsViewState();
}

class _AnswerFromOptionsViewState extends State<AnswerFromOptionsView>
    with Hook, Logger {
  int userAnswer = -1;

  @override
  void initState() {
    super.initState();

    setState(() {
      userAnswer = widget.previousUserAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onUserClick(int id) {
      if (widget.onOptionClick != null) {
        widget.onOptionClick!(id);
        setState(() {
          userAnswer = id;
        });
      }
    }

    return Column(
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _option(0, onUserClick),
            const SizedBox(height: 10),
            _option(1, onUserClick),
            const SizedBox(height: 10),
            _option(2, onUserClick),
            const SizedBox(height: 10),
            _option(3, onUserClick),
          ],
        ),
        const SizedBox(height: 10),
        Center(
          child: RoundedButton(
            onPressed: () {
              if (widget.onConfirmClick != null) {
                widget.onConfirmClick!();
              }
            },
            child: const SizedBox(
              width: 100,
              child: Center(
                child: Text('check'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15)
      ],
    );
  }

  Widget _option(int id, Function(int) onClick) {
    return AnswerOption(
      id: id,
      userAnswer: userAnswer,
      description: widget.options[id],
      onClick: onClick,
      width: double.infinity,
      height: 50,
    );
  }
}

class AnswerOption extends StatefulWidget {
  final int id;
  final int userAnswer;
  final Function(int)? onClick;
  final String description;

  final double? width;
  final double? height;

  final Color backgroundColor;
  final Color chooseColor;
  final Color validColor;
  final Color invalidColor;

  const AnswerOption({
    Key? key,
    required this.id,
    required this.userAnswer,
    required this.description,
    this.width,
    this.height,
    this.backgroundColor = Colors.white,
    this.chooseColor = Colors.yellowAccent,
    this.validColor = Colors.green,
    this.invalidColor = Colors.redAccent,
    this.onClick,
  }) : super(key: key);

  @override
  State<AnswerOption> createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: () {
              if (widget.userAnswer == widget.id) {
                return widget.chooseColor;
              } else {
                return widget.backgroundColor;
              }
            }(),
            borderRadius: BorderRadius.circular(Dimens.ROUNDED_S)),
        padding: const EdgeInsets.all(10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.description,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
      onTap: () {
        if (widget.onClick != null) {
          widget.onClick!(widget.id);
        }
      },
    );
  }
}
