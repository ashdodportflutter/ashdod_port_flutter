
import 'package:ashdod_port_flutter/models/user.dart';

class UserModel {
  List<AppUser>? users;
  String? hint;
  String? errorSearch;

  UserModel({this.hint, this.errorSearch, this.users});
}
