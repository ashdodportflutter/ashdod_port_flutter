import 'package:intl/intl.dart';
import 'package:observers_manager/observer_response.dart';

extension Error on String {
  ErrorModel get error {
    var error = ErrorModel(title: 'Error', message: this, actions: [
      'Try Again',
      'Cancel'
    ]);
    return error;
  }
}

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

  String get dateKey {
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
