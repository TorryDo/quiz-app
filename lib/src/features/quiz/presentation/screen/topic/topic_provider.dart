import 'package:flutter/material.dart';
import 'package:quiz_app/core/side_effect/side_effect_notifier.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/topic/topic_screen_side_effect.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import '../../../domain/repository/quiz_repository.dart';
import '../volume/volume_provider.dart';


class TopicProvider extends ChangeNotifier with SideEffectNotifier<TopicScreenSideEffect>{

  final QuizRepository _quizRepository;

  List<Topic> topics = [];

  TopicProvider(this._quizRepository){
    _quizRepository.collectTopics().listen((updatedTopics) {
      topics.clearAdd(updatedTopics);
      notifyListeners();
    });
  }

  void navigateToVolumeScreen(BuildContext context, Topic topic) {
    VolumeProvider volumeProvider = context.provider(listen: false);
    volumeProvider.prepare(topic);
    postSideEffect(NavigateToVolumeScreen());
  }

}