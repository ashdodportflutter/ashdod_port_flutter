import 'package:ashdod_port_flutter/models/user.dart';

class DayModel {
  String? day;
  String? arrived;
  String? left;
  String? month;
  String? dayPresent;
  String? hourPresentArrived;
  String? hourPresentLeft;

  DayModel(Map<String, dynamic> map) {
    arrived = DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).timestamp();
    left = DateTime.fromMillisecondsSinceEpoch(map['left'] as int).timestamp();
    day = DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).getMonth();
    month=DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).getMonthString();
    dayPresent=DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).getDay();
    hourPresentArrived=DateTime.fromMillisecondsSinceEpoch(map['arrived'] as int).getHour();
    hourPresentLeft=DateTime.fromMillisecondsSinceEpoch(map['left'] as int).getHour();
  }
}
