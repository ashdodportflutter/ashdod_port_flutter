import 'package:observers_manager/observer_response.dart';

class Result<T> {
  T? success;
  String? type;
  ErrorModel? failure;

  Result.success({this.success, this.type});
  Result.error({this.failure});
}

class Request<T> {
  Map<String, dynamic>? info;
  final String name;

  Request({required this.name, this.info});
}

abstract class Server {
  Future<Result<String>> login({required String email, required String password});
  Future<Result<bool>> resetPassword({required String email});
  Future<Result> fetchData<T>({required Request<T> request});
}