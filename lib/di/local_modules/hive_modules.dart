import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/src/features/save_result/data/model/hive_quiz_result.dart';
import 'package:quiz_app/src/features/save_result/data/repository/hive_localdb_repository__impl.dart';
import 'package:quiz_app/src/features/save_result/domain/repository/local_database_repository.dart';

const _DEFAULT_BOX_NAME = "default_box";

Future hiveModules() async{
  await Hive.initFlutter();
  Hive.registerAdapter(HiveQuizResultAdapter());
  await Hive.openBox<HiveQuizResult>(_DEFAULT_BOX_NAME);

  locator.registerSingleton<LocalDatabaseRepository>(HiveLocalDbRepositoryImpl());
}