import 'package:flutter/widgets.dart';
import 'package:quiz_app/di/locator.dart';
import 'package:quiz_app/src/features/auth/domain/models/account.dart';
import 'package:quiz_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:quiz_app/utils/logger.dart';
import 'package:quiz_app/utils/models/resource/resource_x.dart';

class AuthViewModel extends ChangeNotifier {
  late AuthRepository _authRepository;

  Account? account;

  AuthViewModel() {
    _authRepository = locator<AuthRepository>();
    _authRepository.getStream().listen((event) {
      account = event;
      logger.d(event?.uid.toString() ?? '-');
      notifyListeners();
    });
  }

  void signInWithGoogle() {
    _authRepository.signIn().onSuccess((value) {
      account = value;
      notifyListeners();
    }).onError((errorType, value) {
      logger.e(errorType?.message ?? '');
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
