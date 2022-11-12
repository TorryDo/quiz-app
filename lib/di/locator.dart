import 'package:get_it/get_it.dart';
import 'package:quiz_app/di/remote_modules/local_modules.dart';
import 'package:quiz_app/di/remote_modules/remote_modules.dart';

var locator = GetIt.instance;

void setupLocator(){
  remoteModule();
  localModules();
}