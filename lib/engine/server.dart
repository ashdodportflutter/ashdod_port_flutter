class Result<T> {
  T? success;
  String? failure;

  Result.success({this.success});
  Result.error({this.failure});
}

abstract class Server {
  Future<Result<String>> login({required String email, required String password});
  Future<Result<bool>> resetPassword({required String email});
}