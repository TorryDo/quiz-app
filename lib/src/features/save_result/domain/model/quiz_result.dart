class QuizResult {
  int id;
  int validNumber;
  int quizId;

  QuizResult({
    this.id = 0,
    required this.validNumber,
    required this.quizId,
  });

  QuizResult copyWith({
    int? id,
    int? validNumber,
    int? quizId,
  }) =>
      QuizResult(
        id: id ?? this.id,
        validNumber: validNumber ?? this.validNumber,
        quizId: quizId ?? this.quizId
      );
}
