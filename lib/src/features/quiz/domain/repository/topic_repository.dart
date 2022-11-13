import '../models/question.dart';
import '../models/topic.dart';
import '../models/volume.dart';

abstract class QuizRepository {
  Stream<List<Topic>> collectTopics();
  // Stream<List<Topic>> collectTopicsByVolume(Volume volume);

  Stream<List<Volume>> collectVolumes();
  Stream<List<Volume>> collectVolumesByTopic(Topic topic);
  List<Volume> getVolumesByTopic(Topic topic);

  Stream<List<Question>> collectQuestions();
  Stream<List<Question>> collectQuestionsByVolume(Volume volume);
  List<Question> getQuestionsByVolume(Volume volume);
}
