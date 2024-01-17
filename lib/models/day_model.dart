import 'package:ashdod_port_flutter/models/user.dart';

class DayModel {
  String? day;
  String? arrived;
  String? left;

  DayModel(Map<String, dynamic> map) {
    arrived = DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).timestamp();
    left = DateTime.fromMillisecondsSinceEpoch(map['left'] as int).timestamp();
    day = DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).birthDate();
  }
}
