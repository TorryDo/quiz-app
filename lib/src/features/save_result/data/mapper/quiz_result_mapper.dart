import 'package:quiz_app/src/features/save_result/data/model/hive_quiz_result.dart';
import 'package:quiz_app/src/features/save_result/domain/model/quiz_result.dart';

extension HiveQuizResultX on HiveQuizResult {
  QuizResult toQuizResult() {
    return QuizResult(
      validNumber: this.validNumber,
      quizId: this.quizId,
      submittedTime: this.submittedTime,
    );
  }
}

extension QuizResultX on QuizResult {
  HiveQuizResult toHiveQuizResult() {
    return HiveQuizResult()
      ..quizId = this.quizId
      ..validNumber = this.validNumber
      ..submittedTime = this.submittedTime;
  }
}
