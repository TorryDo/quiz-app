import 'package:quiz_app/utils/exceptions/error_type.dart';
import 'package:quiz_app/utils/models/resource/resource.dart';

extension ResourceX<T> on Future<Resource<T>> {

  Future<Resource<T>> onSuccess(Function(T? value) onValue) {
    then((resource) {
      if (resource.isSuccess()) {
        onValue(resource.data);
      }
    });
    return this;
  }

  Future<Resource<T>> onError(Function(ErrorType? errorType, T? value) onValue) {
    then((resource) {
      if (resource.isError()) {
        onValue(resource.errorType, resource.data);
      }
    });
    return this;
  }
}

extension Any2ResourceX<T> on T{

  Resource<T> toResourceSuccess(){
    return Resource.Success(this);
  }

  // Resource<T> toResourceError(ErrorType errorType, T? data){
  //   return Resource.Error(errorType, data);
  // }

}