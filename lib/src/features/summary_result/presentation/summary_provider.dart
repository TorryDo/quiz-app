import 'package:flutter/material.dart';

import '../../quiz/domain/models/question.dart';

SummaryProvider initSummaryProvider() {
  return SummaryProvider();
}

class SummaryProvider extends ChangeNotifier {
  List<Question> questions = [];

  SummaryProvider();

  void prepare(List<Question> questions) {
    this.questions = questions;
  }
}
