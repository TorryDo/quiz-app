import 'package:quiz_app/src/features/topics/domain/models/topic.dart';
import 'package:quiz_app/src/features/topics/domain/repository/topic_repository.dart';

class FakeTopicRepositoryImpl extends TopicRepository{


  @override
  Stream<List<Topic>> getStream() async*{


  }

}