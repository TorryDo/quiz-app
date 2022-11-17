import 'package:flutter/material.dart';

import '../../quiz/domain/models/question.dart';

SummaryProvider initSummaryProvider() {
  return SummaryProvider();
}

class SummaryProvider extends ChangeNotifier {
  List<Question> questions = [];

  get questionLength => questions.length;

  SummaryProvider();

  void prepare(List<Question> questions) {
    this.questions = questions;
  }

  // logic code

  int validQuestionCount() {
    int count = 0;
    for (var question in questions) {
      if (question.questionAnswer.isValid()) {
        count++;
      }
    }
    return count;
  }
}
