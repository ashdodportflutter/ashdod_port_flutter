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