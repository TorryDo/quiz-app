import 'package:flutter/material.dart';

abstract class QuestionAnswer {
  bool isValid();

  void setUserAnswer(dynamic any);

  Widget renderInput();
}

class AnswerFromOptions extends QuestionAnswer {
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
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _singleOption(options[0], 0),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: _singleOption(options[1], 1)
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _singleOption(options[2], 2)),
            const SizedBox(width: 10),
            Expanded(child: _singleOption(options[3], 3))
          ],
        )
      ],
    );
  }

  Widget _singleOption(String str, int position) {
    return GestureDetector(
      child: Container(
        color: Colors.blueAccent,
        padding: const EdgeInsets.all(10),
        child: Text(str),
      ),
      onTap: (){
        userAnswer = position;


      },
    );
  }
}
