import 'package:flutter/widgets.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/summary_result/presentation/summary_provider.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../domain/models/question.dart';
import '../../domain/models/volume.dart';
import '../../domain/repository/quiz_repository.dart';

class QuizProvider extends ChangeNotifier with Logger {
  final QuizRepository _quizRepository;

  late Volume volume;
  List<Question> questions = [];

  int _currentQuestion = 0;
  set currentQuestion(value) {
    _currentQuestion = value;
    notifyListeners();
  }
  get currentQuestion => _currentQuestion;

  QuizProvider(this._quizRepository);

  void prepare(Volume volume) {
    this.volume = volume;
    currentQuestion = 0;
    questions.clearAdd(_quizRepository.getQuestionsByVolume(volume));
    notifyListeners();
  }

  void navigateToSummaryScreen(BuildContext context) {
    SummaryProvider summaryProvider = context.provider(listen: false);
    summaryProvider.prepare(questions);
    context.popAndPushNamed(Routes.SUMMARY_SCREEN);
  }
}
