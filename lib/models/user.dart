import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:intl/intl.dart';

  extension Split on String {
    List<String> get splitToSubStrings {
      var substrings = <String>[];
      for (var i = 1; i <= length; i++) {
        substrings.add(substring(0, i).toLowerCase());
         substrings.add(substring(i - 1, i));
      }

      return substrings;
    }
  }

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
  String getDay() {
    return DateFormat('dd').format(this);
  }
  String getHour() {
    return DateFormat('HH:mm').format(this);
  }
  String getMonth() {
    return DateFormat('MM').format(this);
  }
  String getMonthString() {
    return DateFormat('MMMM yyyy').format(this);
  }
}

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