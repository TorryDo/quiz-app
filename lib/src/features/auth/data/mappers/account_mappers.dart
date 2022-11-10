import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/src/features/auth/domain/models/account.dart';

extension UserX on User {
  Account toAccount() {
    return Account(uid: this.uid);
  }
}

extension GAccountX on GoogleSignInAccount {
  Account toAccount() {
    return Account(uid: this.id);
  }
}
