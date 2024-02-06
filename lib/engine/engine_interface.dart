import 'package:ashdod_port_flutter/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ARequest<T> {
  Map<String, dynamic>? info;
  final String primary;
  final String secondary;
  ARequest({required this.primary, required this.secondary});
}

class AResult<T> {
  T? success;
  String? failure;

  AResult.success({this.success});
  AResult.error({this.failure});
}

class LoginRequest extends ARequest<User> {
  LoginRequest({required super.primary, required super.secondary});

}

class UserRequest extends ARequest<AppUser> {
  UserRequest({required super.primary, required super.secondary});

}

abstract class AResponse<T> {

}

 abstract class BaseEngine {
  appLogin(ARequest loginData);
  register(ARequest data);
  resetPassword([ARequest? data]);
  fetchData(ARequest request);
  updateUser(ARequest request);
}