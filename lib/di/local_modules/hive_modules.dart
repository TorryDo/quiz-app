import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/src/features/save_result/data/model/hive_quiz_result.dart';
import 'package:quiz_app/src/features/save_result/data/repository/hive_localdb_repository__impl.dart';
import 'package:quiz_app/src/features/save_result/domain/repository/local_database_repository.dart';


Future hiveModules() async{
  await Hive.initFlutter();
  Hive.registerAdapter(HiveQuizResultAdapter());

  locator.registerSingleton<LocalDatabaseRepository>(HiveLocalDbRepositoryImpl(boxName: DEFAULT_BOX_NAME));

  await locator<LocalDatabaseRepository>().clear();

}