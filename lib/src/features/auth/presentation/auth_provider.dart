import 'package:flutter/widgets.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/src/features/auth/domain/models/account.dart';
import 'package:quiz_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:quiz_app/utils/logger.dart';
import 'package:quiz_app/utils/models/resource/resource_x.dart';

AuthProvider initAuthProvider(){
  return AuthProvider();
}

class AuthProvider extends ChangeNotifier with Logger {
  late AuthRepository _authRepository;

  Account? account;

  AuthProvider() {
    _authRepository = locator<AuthRepository>();
    _authRepository.collectAccount().listen((event) {
      account = event;
      d(event?.uid.toString() ?? '-');
      notifyListeners();
    });
  }

  void signInWithGoogle() {
    _authRepository.signIn().onSuccess((value) {
      account = value;
      notifyListeners();
    }).onError((errorType, value) {
      e(errorType?.message ?? '');
    });
  }

  void signOut() {
    _authRepository.signOut().onSuccess((value) {
      account = null;
      notifyListeners();
    });
  }

  void signInAsGuest() {}
}
