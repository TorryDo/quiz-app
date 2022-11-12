import 'package:quiz_app/src/features/auth/domain/models/account.dart';
import 'package:quiz_app/utils/models/resource/resource.dart';

abstract class AuthRepository{

  Future<Resource<Account>> getCurrentAccount();

  Stream<Account?> collectAccount();

  Future<Resource<Account>> signIn();

  Future<Resource<void>> signOut();

}