import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/src/features/save_result/data/mapper/quiz_result_mapper.dart';
import 'package:quiz_app/src/features/save_result/data/model/hive_quiz_result.dart';
import 'package:quiz_app/src/features/save_result/domain/model/quiz_result.dart';
import 'package:quiz_app/src/features/save_result/domain/repository/local_database_repository.dart';
import 'package:quiz_app/utils/lang/map_ext.dart';

class HiveLocalDbRepositoryImpl extends LocalDatabaseRepository {
  final String boxName;

  HiveLocalDbRepositoryImpl({
    this.boxName = "default",
  });

  @override
  Future<QuizResult> insert(QuizResult quizResult) async {
    final box = await Hive.openBox(boxName);

    var hiveQuizResult = quizResult.toHiveQuizResult();

    final updatedId = await box.add(hiveQuizResult);

    return hiveQuizResult.toQuizResult().copyWith(id: updatedId);
  }

  @override
  Future<bool> update(QuizResult quizResult) async {
    final box = await Hive.openBox(boxName);
    HiveQuizResult? oldValue = box.get(quizResult.id);

    if (oldValue == null) return false;

    oldValue.validNumber = quizResult.validNumber;

    await oldValue.save();

    return true;
  }

  @override
  Future<QuizResult?> delete(QuizResult quizResult) async {
    final box = await Hive.openBox(boxName);
    HiveQuizResult? oldValue = box.get(quizResult.id);

    if (oldValue == null) return null;

    await oldValue.delete();

    return quizResult;
  }

  @override
  Future<List<QuizResult>> getAll() async {
    final box = await Hive.openBox(boxName);

    List<QuizResult> quizResults = box.keys.mapNotNull((key) {
      final temp = (box.get(key) as HiveQuizResult?);
      if(temp == null) return null;
      return temp.toQuizResult();
    });

    return quizResults;
  }

  @override
  Stream<List<QuizResult>> collectAll() async* {
    final box = await Hive.openBox(boxName);

    yield await getAll();

    yield* box.watch().map((event) {
      List<HiveQuizResult> hiveQuizResults =  List.from(box.values);
      return hiveQuizResults.map((e) => e.toQuizResult()).toList();
    });
  }
}
