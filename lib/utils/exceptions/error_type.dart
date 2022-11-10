class ErrorType{
  final String message;

  ErrorType(this.message);


  factory ErrorType.NoInternet(String message) = NoInternet;
}

class UserNotLoggedIn extends ErrorType{

  UserNotLoggedIn(super.message);

}

class NoInternet extends ErrorType{
  NoInternet(super.message);
}