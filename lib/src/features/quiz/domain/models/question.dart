import 'package:quiz_app/src/features/quiz/domain/models/question_answer.dart';
import 'package:quiz_app/src/features/quiz/domain/models/question_description.dart';

class Question {
  int id;
  int volumeId;

  QuestionDescription questionDescription;
  QuestionAnswer questionAnswer;

  Question({required this.id,
    required this.volumeId,
    required this.questionDescription,
    required this.questionAnswer});


  Question copyWith({int? id,
    int? volumeId,
    QuestionDescription? questionDescription,
    QuestionAnswer? questionAnswer}) {
    return Question(
        id: id ?? this.id,
        volumeId: volumeId ?? this.volumeId,
        questionDescription: questionDescription ?? this.questionDescription,
        questionAnswer: questionAnswer ?? this.questionAnswer);
  }
}
