import 'package:flutter/material.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import '../../domain/repository/quiz_repository.dart';
import 'volume_provider.dart';


class TopicProvider extends ChangeNotifier{

  final QuizRepository _quizRepository;

  List<Topic> topics = [];

  TopicProvider(this._quizRepository){
    _quizRepository.collectTopics().listen((updatedTopics) {
      topics.clearAdd(updatedTopics);
      notifyListeners();
    });
  }

  void navigateToVolumeScreen(BuildContext context, Topic topic){
    VolumeProvider volumeProvider = context.provider(listen: false);
    volumeProvider.updateByTopic(topic);
    context.pushNamed(Routes.VOLUME_SCREEN);
  }

}