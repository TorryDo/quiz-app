import 'package:get_it/get_it.dart';
import 'package:quiz_app/di/local_modules/hive_modules.dart';
import 'package:quiz_app/di/remote_modules/local_modules.dart';
import 'package:quiz_app/di/remote_modules/remote_modules.dart';

var locator = GetIt.instance;

Future<void> setupLocator() async {
  await hiveModules();
  remoteModule();
  localModules();

}
