import 'dart:typed_data';

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
  Function(bool)? onAuthState;
  Future<Result<String>> createAccount({required String email, required String password});
  Future<Result<String>> login({required String email, required String password});
  Future<Result<bool>> resetPassword({required String email});
}

abstract class DataFetcher {
  Future<Result<List<RoleModel>>> fetchRoles();
  Future<Result<bool>> updateUser(Map<String, dynamic> data);
  Future updateTime(Map<String, dynamic> data);
  imageTimeStamp(String path);
  Function(DateTime)? onImageTimeStamp;
}

abstract class Storage {
  Function(Uint8List?)? onImageUpdate;
}

abstract class Server {
  Auth get authenticator;
  DataFetcher get fetcher;
}