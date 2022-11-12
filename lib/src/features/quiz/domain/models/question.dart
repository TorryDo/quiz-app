
import 'package:quiz_app/src/features/quiz/domain/models/question_answer.dart';
import 'package:quiz_app/src/features/quiz/domain/models/question_description.dart';

class Question{

  int id;
  int volumeId;

  QuestionDescription questionDescription;
  QuestionAnswer questionAnswer;

  Question({
    required this.id,
    required this.volumeId,
    required this.questionDescription,
    required this.questionAnswer
  });

}