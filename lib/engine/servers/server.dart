import 'package:ashdod_port_flutter/models/role_model.dart';
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

abstract class Auth {
  Future<Result<String>> createAccount({required String email, required String password});
  Future<Result<String>> login({required String email, required String password});
  Future<Result<bool>> resetPassword({required String email});
}

abstract class DataFetcher {
  Future<Result<List<RoleModel>>> fetchRoles();
  Future<Result<bool>> updateUser(Map<String, dynamic> data);
}

abstract class Server {
  Auth get authenticator;
  DataFetcher get fetcher;
}