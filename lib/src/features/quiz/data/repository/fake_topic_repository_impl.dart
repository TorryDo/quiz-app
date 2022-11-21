import 'package:quiz_app/utils/lang/list_ext.dart';

import '../../../../../utils/logger.dart';
import '../../domain/models/question.dart';
import '../../domain/models/question_answer.dart';
import '../../domain/models/question_description.dart';
import '../../domain/models/topic.dart';
import '../../domain/models/volume.dart';
import '../../domain/repository/quiz_repository.dart';

class FakeQuizRepositoryImpl extends QuizRepository with Logger {
  final _fakeTopics = [
    Topic(id: 1, title: "Topic 1", description: "description of topic1"),
    Topic(id: 2, title: "Topic 2", description: "description of topic2"),
    Topic(id: 3, title: "Topic 3", description: "description of topic3"),
  ];

  final _fakeVolumes = [
    Volume(id: 1, topicId: 1, title: 'volume 1'),
    Volume(id: 2, topicId: 1, title: 'volume 2'),
    Volume(id: 3, topicId: 1, title: 'volume 3'),
    Volume(id: 4, topicId: 1, title: 'volume 4'),
    Volume(id: 5, topicId: 1, title: 'volume 5'),
    // -----------------------------------------
    Volume(id: 6, topicId: 2, title: 'volume 6'),
    Volume(id: 7, topicId: 2, title: 'volume 7'),
    Volume(id: 8, topicId: 2, title: 'volume 8'),
    Volume(id: 9, topicId: 2, title: 'volume 9'),
    // -----------------------------------------
    Volume(id: 10, topicId: 3, title: 'volume 10'),
    Volume(id: 11, topicId: 3, title: 'volume 11'),
    Volume(id: 12, topicId: 3, title: 'volume 12'),
  ];

  final List<Question> _fakeQuestions = [];

  FakeQuizRepositoryImpl() {
    int temp = 1;
    for (int i = 1; i <= 36; i++) {
      _fakeQuestions.add(
        Question(
          id: i,
          volumeId: temp,
          questionDescription: DescriptionOnly(
            'who developed this app? id$i',
          ),
          questionAnswer: AnswerFromOptions(
            options: ["torrydo", "abc", "xyz", "hahaha"],
            position: 0,
          ),
        ),
      );
      if (i % 3 == 0) {
        temp++;
      }
    }
  }

  @override
  Stream<List<Topic>> collectTopics() async* {
    e("return fake data");
    yield _fakeTopics;
  }

  @override
  Stream<List<Question>> collectQuestions() async* {
    e("return fake data");
    yield _fakeQuestions;
  }

  @override
  Stream<List<Question>> collectQuestionsByVolume(Volume volume) async* {
    e("return fake data");
    yield _fakeQuestions.filter((element) => element.volumeId == volume.id);
  }

  @override
  Stream<List<Volume>> collectVolumes() async* {
    e("return fake data");
    yield _fakeVolumes;
  }

  @override
  Stream<List<Volume>> collectVolumesByTopic(Topic topic) async* {
    e("return fake data");
    yield _fakeVolumes.filter((it) => it.topicId == topic.id);
  }

  @override
  List<Question> getQuestionsByVolume(Volume volume) {
    e("return fake data");
    List<Question> ql = [];

    return _fakeQuestions.filter((it) => it.volumeId == volume.id);
  }

  @override
  List<Volume> getVolumesByTopic(Topic topic) {
    e("return fake data");

    return _fakeVolumes.filter((it) => it.topicId == topic.id);
  }
}
