import 'package:flutter/widgets.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../../../../di/locator.dart';
import '../../domain/models/question.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/volume.dart';
import '../../domain/repository/quiz_repository.dart';


class QuizProvider extends ChangeNotifier with Logger {

  final QuizRepository _quizRepository;

  late Volume volume;
  List<Question> questions = [];

  int questionPosition = 0;

  QuizProvider(this._quizRepository);

  void updateQuestionsByVolume(Volume volume){
    this.volume = volume;
    questions.clearAdd(_quizRepository.getQuestionsByVolume(volume));
    notifyListeners();
  }

}
