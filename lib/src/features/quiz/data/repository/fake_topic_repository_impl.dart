import '../../../../../utils/logger.dart';
import '../../domain/models/question.dart';
import '../../domain/models/question_answer.dart';
import '../../domain/models/question_description.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/volume.dart';
import '../../domain/repository/quiz_repository.dart';

class FakeQuizRepositoryImpl extends QuizRepository with Logger {
  final _fakeTopic = Topic(
    id: 0,
    title: "super awesome title",
    description: "awesome description"
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

    List<Topic> tl = [];

    for (var i = 0; i < 15; i++) {
      var temp = (_fakeTopic.copyWith(id: i, title: 'topic title $i'));
      tl.add(temp);
    }

    yield tl;
  }

  @override
  Stream<List<Question>> collectQuestions() async* {
    e("return fake data");

    List<Question> ql = [];

    for (var i = 0; i < 5; i++) {
      var temp = (_fakeQuestion.copyWith(id: i));
      ql.add(temp);
    }

    yield ql;
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

  @override
  List<Question> getQuestionsByVolume(Volume volume) {
    e("return fake data");
    List<Question> ql = [];

    for (var i = 0; i < 3; i++) {

      var tempAnswer = AnswerFromOptions(options: ['torydo$i', 'idk', 'dkm', 'kut'], position: 0);

      var temp = (_fakeQuestion.copyWith(
        id: i,
        questionDescription: DescriptionOnly('who developed this app ${i}?'),
        questionAnswer: tempAnswer,
      ));
      ql.add(temp);
    }
    return ql;
  }

  @override
  List<Volume> getVolumesByTopic(Topic topic) {
    List<Volume> vl = [];

    for (var i = 0; i < 15; i++) {
      var temp = (_fakeVolume.copyWith(id: i, title: 'not awesome volume $i'));
      vl.add(temp);
    }

    return vl;
  }
}
