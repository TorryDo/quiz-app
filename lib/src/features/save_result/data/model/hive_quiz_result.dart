import 'package:hive/hive.dart';
part 'hive_quiz_result.g.dart';

@HiveType(typeId: 0)
class HiveQuizResult extends HiveObject{

  @HiveField(0)
  late int validNumber;

  @HiveField(1)
  late int quizId;

  @HiveField(2)
  late DateTime submittedTime;

}