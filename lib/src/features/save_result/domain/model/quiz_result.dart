class QuizResult {
  int id;
  int validNumber;
  int quizId;

  DateTime submittedTime;

  QuizResult({
    this.id = 0,
    required this.validNumber,
    required this.quizId,
    required this.submittedTime,
  });

  QuizResult copyWith({
    int? id,
    int? validNumber,
    int? quizId,
    DateTime? submittedTime,
  }) =>
      QuizResult(
        id: id ?? this.id,
        validNumber: validNumber ?? this.validNumber,
        quizId: quizId ?? this.quizId,
        submittedTime: submittedTime ?? this.submittedTime
      );
}
