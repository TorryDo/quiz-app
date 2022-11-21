import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quiz_app/core/side_effect/side_effect_notifier.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/src/features/save_result/domain/model/quiz_result.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_result_side_effect.dart';
import 'package:quiz_app/utils/lang/pair.dart';

import '../../quiz/domain/models/question.dart';
import '../../save_result/domain/repository/local_database_repository.dart';

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

class SummaryProvider extends ChangeNotifier
    with SideEffectNotifier<SummaryResultSideEffect> {
  // var -----------------------------------------------------------------------
  List<Question> questions = [];
  final LocalDatabaseRepository localDatabaseRepository = locator();

  SummaryProvider() {
    localDatabaseRepository.collectAll().listen((event) {
      log("<> size is ${event.length}");
    });
  }

  void prepare(List<Question> questions) async {
    this.questions = questions;

    final quizResult = QuizResult(
        validNumber: _validQuestionCount(),
        quizId: questions[0].volumeId,
        submittedTime: DateTime.now()
    );

    await localDatabaseRepository.insert(quizResult);

  }

  void navigateToVolumeScreen() {
    postSideEffect(NavigateBack());
  }

  void replay() {
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
