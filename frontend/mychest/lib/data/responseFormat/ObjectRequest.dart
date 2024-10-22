class ObjectRequest <T>{
  T object;
  int statusCode = -1;
  String? errorMessage;
  ObjectRequest({required this.object, this.statusCode = -1, this.errorMessage});
  T get getObject => object;
  set setObject(T obj) => object = obj;

  int get getStatusCode => statusCode;
  set setStatusCode(int code) => statusCode = code;

  String? get getErrorMessage => errorMessage;
  set setErrorMessage(String? message) => errorMessage = message;

  @override
  String toString() {
    return 'ObjectRequest(object: $object, statusCode: $statusCode, errorMessage: $errorMessage)';
  }
}