import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/src/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quiz_app/src/features/save_result/domain/model/quiz_result.dart';
import 'package:quiz_app/src/features/save_result/domain/repository/local_database_repository.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import '../../../domain/models/volume.dart';
import '../quiz/quiz_provider.dart';

VolumeProvider initVolumeProvider() {
  return VolumeProvider(locator(), locator());
}

class VolumeProvider extends ChangeNotifier {
  final QuizRepository _quizRepository;

  final LocalDatabaseRepository _localDbRepo;

  final Map<int, QuizResult> quizMap = {};

  late Topic topic;

  final List<Volume> volumes = [];

  VolumeProvider(
    this._quizRepository,
    this._localDbRepo,
  ) {
    _localDbRepo.collectAll().listen((quizzes) {
      log("<> update on volume, size = ${quizzes.length}");
      for (final quiz in quizzes) {
        if (quizMap[quiz.quizId] == null) {
          quizMap[quiz.quizId] = quiz;
          continue;
        }
        if (quiz.validNumber > quizMap[quiz.quizId]!.validNumber) {
          quizMap[quiz.quizId] = quiz;
        }
      }
      notifyListeners();
    });
  }

  void prepare(Topic topic) {
    this.topic = topic;
    volumes.clearAdd(_quizRepository.getVolumesByTopic(topic));
    notifyListeners();
  }

  void navigateToQuizScreen(BuildContext context, Volume volume) {
    QuizProvider quizProvider = context.provider(listen: false);
    quizProvider.prepare(volume);
    context.pushNamed(Routes.QUIZ_SCREEN);
  }
}
