import 'package:get_it/get_it.dart';
import 'package:quiz_app/src/features/auth/data/repository/firebase_auth_repository_impl.dart';
import 'package:quiz_app/src/features/auth/domain/repository/auth_repository.dart';

import '../locator.dart';

void remoteModule() {
  // GetIt.I.registerSingleton<AuthRepository>(FirebaseAuthRepositoryImpl());
  locator.registerSingleton<AuthRepository>(FirebaseAuthRepositoryImpl());
}