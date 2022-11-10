import 'package:quiz_app/src/features/topics/domain/models/topic.dart';

abstract class TopicRepository {

  Stream<List<Topic>> getStream();

}