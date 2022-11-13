import 'package:flutter/cupertino.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/src/features/quiz/domain/models/topic.dart';
import 'package:quiz_app/src/features/quiz/domain/repository/quiz_repository.dart';
import 'package:quiz_app/src/features/quiz/presentation/screen/quiz_provider.dart';
import 'package:quiz_app/utils/framework/navigation_ext.dart';
import 'package:quiz_app/utils/lang/list_ext.dart';
import 'package:quiz_app/utils/lib/provider/provider_ext.dart';

import '../../domain/models/volume.dart';


VolumeProvider initVolumeProvider(){
  return VolumeProvider(locator());
}

class VolumeProvider extends ChangeNotifier{

  final QuizRepository _quizRepository;

  late Topic topic;

  List<Volume> volumes = [];

  VolumeProvider(this._quizRepository);

  void updateByTopic(Topic topic){
    this.topic = topic;
    volumes.clearAdd(_quizRepository.getVolumesByTopic(topic));
    notifyListeners();
  }

  void navigateToQuizScreen(BuildContext context, Volume volume){
    QuizProvider quizProvider = context.provider(listen: false);
    quizProvider.prepare(volume);
    context.pushNamed(Routes.QUIZ_SCREEN);
  }



}