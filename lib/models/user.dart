import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:intl/intl.dart';

extension MyDateFormat on DateTime {
  String birthDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  String dateKey() {
    return DateFormat('dd_MM_yyyy').format(this);
  }

  String timestamp() {
    return DateFormat('dd/MM/yyyy - HH:mm:ss').format(this);
  }
}

class AppUser {
  String? id;
  String? name;
  String? duty;
  DateTime? birthDate;
  RoleModel? role;

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
  }


  static final AppUser _instance = AppUser._();
  static AppUser get instance => _instance;

  AppUser._();

}