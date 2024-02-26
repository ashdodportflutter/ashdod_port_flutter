import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:intl/intl.dart';


class AppUser {
  String? id;
  String? name;
  String? duty;
  DateTime? birthDate;
  RoleModel? role;
  late List<String> splittedName;

  update(Map<String, dynamic> map) {
    name = map['name'];
    duty = map['duty'];
    var timestamp = map['birthDate'];
    if (timestamp != null) {
      birthDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (map['role'] != null) {
      role = RoleModel(map: map['role']);
    }
    if (map['splittedName'] != null) {
      splittedName = map['splittedName'].cast<String>();
    }
  }


  static final AppUser _instance = AppUser._();
  static AppUser get instance => _instance;

  AppUser._();
  AppUser.fromMap(Map<String, dynamic> map) {
    update(map);
  }
}