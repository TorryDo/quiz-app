import 'package:quiz_app/src/features/save_result/domain/model/quiz_result.dart';

abstract class LocalDatabaseRepository{
  Future<QuizResult> insert(QuizResult quizResult);
  Future<bool> update(QuizResult quizResult);
  Future<QuizResult?> delete(QuizResult quizResult);
  Future<bool> clear();

  Future<List<QuizResult>> getAll();
  Stream<List<QuizResult>> collectAll();
  Future<bool> isExisted(QuizResult quizResult);

}