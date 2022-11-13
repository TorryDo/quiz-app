class Volume {
  int id;
  int topicId;
  String title;

  // may not placed here
  QuizType quizType;

  Volume(
      {required this.id,
      required this.topicId,
      required this.title,
      this.quizType = QuizType.SINGLE_QUESTION_NO_LIMIT_TIME});

  Volume copyWith({int? id, int? topicId, String? title}) {
    return Volume(
        id: id ?? this.id,
        topicId: topicId ?? this.topicId,
        title: title ?? this.title);
  }
}

enum QuizType {
  SINGLE_QUESTION_NO_LIMIT_TIME,
  SINGLE_QUESTION_LIMIT_TIME,
  MULTI_QUESTION_NO_LIMIT_TIME,
  MULTI_QUESTION_LIMIT_TIME
}
