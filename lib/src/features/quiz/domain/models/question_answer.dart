import 'package:flutter/material.dart';
import 'package:quiz_app/core/side_effect.dart';
import 'package:quiz_app/src/features/quiz/presentation/view/question_option.dart';
import 'package:quiz_app/utils/logger.dart';

abstract class QuestionAnswer {
  bool isValid();

  void setUserAnswer(dynamic any);

  Widget renderInput();
}

class AnswerFromOptions extends QuestionAnswer with Logger {
  List<String> options = <String>[];
  int position;

  int userAnswer = -1;

  AnswerFromOptions({required this.options, required this.position});

  @override
  bool isValid() {
    return userAnswer == position;
  }

  @override
  void setUserAnswer(any) {
    if (any! is int) throw Exception("answer must be int type");

    userAnswer = any as int;
  }

  // UI ------------------------------------------------------------------------

  @override
  Widget renderInput() {
    return AnswerFromOptionsView(
      options: options,
      previousUserAnswer: userAnswer,
      onOptionClick: (position) {
        userAnswer = position;
      },
    );
  }
}

class AnswerFromOptionsView extends StatefulWidget {
  final List<String> options;
  final Function(int)? onOptionClick;
  final int previousUserAnswer;

  const AnswerFromOptionsView(
      {Key? key, required this.options, this.onOptionClick, required this.previousUserAnswer})
      : super(key: key);

  @override
  State<AnswerFromOptionsView> createState() => _AnswerFromOptionsViewState();
}

class _AnswerFromOptionsViewState extends State<AnswerFromOptionsView> with SideEffect{
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
        setState((){
          userAnswer = id;
        });
      }
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AnswerOption(
                id: 0,
                userAnswer: userAnswer,
                description: widget.options[0],
                onClick: onUserClick,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnswerOption(
                id: 1,
                userAnswer: userAnswer,
                description: widget.options[1],
                onClick: onUserClick,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: AnswerOption(
                id: 2,
                userAnswer: userAnswer,
                description: widget.options[2],
                onClick: onUserClick,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnswerOption(
                id: 3,
                userAnswer: userAnswer,
                description: widget.options[3],
                onClick: onUserClick,
              ),
            )
          ],
        )
      ],
    );
  }
}
