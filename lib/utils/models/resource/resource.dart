import 'package:quiz_app/utils/exceptions/error_type.dart';

abstract class Resource<T> {
  ErrorType? errorType;
  T? data;

  Resource({this.errorType, this.data});

  factory Resource.Success(T? data) = Success<T>;

  factory Resource.Error(ErrorType errorType, {T? data}) = Error<T>;

  bool isSuccess() => this is Success;

  bool isError() => this is Error;
}

class Success<T> extends Resource<T> {
  Success(T? data) : super(errorType: null, data: data);
}

class Error<T> extends Resource<T> {
  Error(ErrorType errorType, {T? data}) : super(errorType: errorType, data: data);
}
