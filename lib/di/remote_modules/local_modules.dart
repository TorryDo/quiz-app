import 'package:quiz_app/di/locator.dart';

import '../../src/features/quiz/data/repository/fake_topic_repository_impl.dart';
import '../../src/features/quiz/domain/repository/quiz_repository.dart';

void localModules() {
  locator.registerSingleton<QuizRepository>(FakeQuizRepositoryImpl());
}
