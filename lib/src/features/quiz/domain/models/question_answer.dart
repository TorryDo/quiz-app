import 'package:flutter/material.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../presentation/view/answer_from_options.dart';

// action ----------------------------------------------------------------------
abstract class QuestionSideEffect {
  QuestionSideEffect();
}

class AnswerValid extends QuestionSideEffect {
  AnswerValid();
}

class AnswerInValid extends QuestionSideEffect {
  AnswerInValid();
}


// View ------------------------------------------------------------------------
abstract class QuestionAnswer {
  @protected
  Function(QuestionSideEffect)? postSideEffect;

  void collectSideEffect(Function(QuestionSideEffect) event) {
    postSideEffect = event;
  }

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
      onConfirmClick: () {
        if (postSideEffect != null) {
          if (isValid()) {
            postSideEffect!(AnswerValid());
          } else {
            postSideEffect!(AnswerInValid());
          }
        }
      },
    );
  }
}
