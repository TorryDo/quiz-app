import 'package:flutter/material.dart';
import 'package:quiz_app/core/side_effect/side_effect_notifier.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_result_side_effect.dart';
import 'package:quiz_app/utils/lang/pair.dart';

import '../../quiz/domain/models/question.dart';

SummaryProvider initSummaryProvider() {
  return SummaryProvider();
}

enum SummaryType {
  SOLVED_ALL,
  SOLVED_80_100,
  SOLVED_65_80,
  SOLVED_50_65,
  SOLVED_25_50,
  SOLVED_0_25
}


class SummaryProvider extends ChangeNotifier with SideEffectNotifier<SummaryResultSideEffect> {

  // var -----------------------------------------------------------------------
  List<Question> questions = [];

  SummaryProvider();

  void navigateToVolumeScreen(){
    postSideEffect(NavigateBack());
  }

  void replay(){
    postSideEffect(Replay());
  }

  Pair<SummaryType, int> calcResult() {
    int validNumber = _validQuestionCount();
    if (validNumber == questions.length) {
      return pairOf(SummaryType.SOLVED_ALL, validNumber);
    }
    if (validNumber >= 80) {
      return pairOf(SummaryType.SOLVED_80_100, validNumber);
    }
    if (validNumber >= 65) {
      return pairOf(SummaryType.SOLVED_65_80, validNumber);
    }
    if (validNumber >= 50) {
      return pairOf(SummaryType.SOLVED_50_65, validNumber);
    }
    if (validNumber >= 25) {
      return pairOf(SummaryType.SOLVED_25_50, validNumber);
    }
    return pairOf(SummaryType.SOLVED_0_25, validNumber);
  }

  void prepare(List<Question> questions) {
    this.questions = questions;
  }

  // logic code

  int _validQuestionCount() {
    int count = 0;
    for (var question in questions) {
      if (question.questionAnswer.isValid()) {
        count++;
      }
    }
    return count;
  }
}
