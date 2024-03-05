import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
  Function(bool)? authState;
  Future<Result<String>> createAccount({required String email, required String password});
  Future<Result<String>> login({required String email, required String password});
  Future<Result<bool>> resetPassword({required String email});
  logout();
}

abstract class DataFetcher {
  Function(Timestamp)? onTimestampChange;
  Future<Result<List<RoleModel>>> fetchRoles();
  Future<Result<bool>> updateUser(Map<String, dynamic> data);
  Future<Result<Map<String, dynamic>>> fetchPresence([Map<String, dynamic>? data]);
  Future<Result<bool>> updatePresence(Map<String, dynamic> data);
  Future<Result<bool>> uploadFile(Uint8List data);
  Future<Result<Uint8List>> fetchUserImage();
}

class BaseRequest<M, T> {
  final M requestData;

  BaseRequest({required this.requestData});

  Result<T> get parse {
    return Result.error();
  }
}


abstract class Server {
  Auth get authenticator;
  DataFetcher get fetcher;
}