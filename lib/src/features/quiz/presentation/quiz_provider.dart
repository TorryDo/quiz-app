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

  int questionPosition = 0;

  QuizProvider(this._quizRepository) {
    _quizRepository.collectTopics().listen((event) {
      topics = event;
      notifyListeners();
    });
  }

  void onTopicTap(Topic topic){
    d("on topic tap");
  }

  void onVolumeTap(Volume volume){
    d("on volume tap");
  }

  void getVolumesByTopic(Topic topic){
    volumes.clearAdd(_quizRepository.getVolumesByTopic(topic));
  }

  void getQuestionsByVolume(Volume volume){
    questions.clearAdd(_quizRepository.getQuestionsByVolume(volume));
  }

}
