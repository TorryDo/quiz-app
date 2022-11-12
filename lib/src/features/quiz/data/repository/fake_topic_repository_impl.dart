import '../../../../../utils/logger.dart';
import '../../domain/models/question.dart';
import '../../domain/models/question_answer.dart';
import '../../domain/models/question_description.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/volume.dart';
import '../../domain/repository/topic_repository.dart';

class FakeQuizRepositoryImpl extends QuizRepository with Logger {
  final _fakeTopic = Topic(
    id: 0,
    title: "super awesome title",
  );

  final _fakeVolume = Volume(id: 0, topicId: 0, title: 'not awesome volume');

  final _fakeQuestion = Question(
      id: 0,
      volumeId: 0,
      questionDescription: DescriptionOnly("who developed this app?"),
      questionAnswer: AnswerFromOptions(
          options: ["torrydo", "abc", "xyz", "hahaha"], position: 0));

  @override
  Stream<List<Topic>> collectTopics() async* {
    e("return fake data");
    yield [_fakeTopic];
  }

  @override
  Stream<List<Question>> collectQuestions() async* {
    e("return fake data");
    yield [_fakeQuestion];
  }

  @override
  Stream<List<Question>> collectQuestionsByVolume(Volume volume) async* {
    e("return fake data");
    yield [_fakeQuestion];
  }

  @override
  Stream<List<Volume>> collectVolumes() async* {
    e("return fake data");
    yield [_fakeVolume];
  }

  @override
  Stream<List<Volume>> collectVolumesByTopic(Topic topic) async* {
    e("return fake data");
    yield [_fakeVolume];
  }
}
