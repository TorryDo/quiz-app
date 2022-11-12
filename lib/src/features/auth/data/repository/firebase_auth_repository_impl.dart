import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/src/features/auth/data/mappers/account_mappers.dart';
import 'package:quiz_app/src/features/auth/domain/models/account.dart';
import 'package:quiz_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:quiz_app/utils/exceptions/error_type.dart';
import 'package:quiz_app/utils/models/resource/resource.dart';

class FirebaseAuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  @override
  Future<Resource<Account>> getCurrentAccount() async {
    var nullableUser = _firebaseAuth.currentUser;
    // var n2 = _googleSignIn.currentUser;

    if (nullableUser == null) {
      return Resource.Success(null);
    }

    return Resource.Success(nullableUser.toAccount());
  }

  @override
  Stream<Account?> collectAccount() async* {
    yield* _firebaseAuth.authStateChanges().asyncMap((event) {
      if (event == null) return null;
      return event.toAccount();
    });
  }

  @override
  Future<Resource<Account>> signIn() async {
    try {
      var user = await _googleSignIn.signIn();

      var googleAuth = await user!.authentication;

      var credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
      );

      await _firebaseAuth.signInWithCredential(credential);

      return Resource.Success(user.toAccount());
    } catch (error) {
      return Resource.Error(ErrorType(error.toString()));
    }
  }

  @override
  Future<Resource<void>> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();

      return Resource.Success(null);
    } catch (error) {
      return Resource.Error(ErrorType(error.toString()));
    }
  }
}
