import 'package:flutter/widgets.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/logger.dart';

import '../../../../di/locator.dart';
import '../domain/models/question.dart';
import '../domain/models/topic.dart';
import '../domain/models/volume.dart';
import '../domain/repository/topic_repository.dart';


QuizProvider initQuizProvider() {
  return QuizProvider(locator<QuizRepository>());
}

class QuizProvider extends ChangeNotifier with Logger {

  final QuizRepository _quizRepository;

  List<Topic> topics = [];
  List<Volume> volumes = [];
  List<Question> questions = [];

  QuizProvider(this._quizRepository) {
    _quizRepository.collectTopics().listen((event) {
      topics.clearAdd(event);
      notifyListeners();
    });
    _quizRepository.collectVolumes().listen((event) {
      volumes.clearAdd(event);
      notifyListeners();
    });
    _quizRepository.collectQuestions().listen((event) {
      questions.clearAdd(event);
      notifyListeners();
    });
  }

  void onTopicTap(Topic topic){
    d("on topic tap");
  }

  void onVolumeTap(Volume volume){
    d("on volume tap");
  }
}
