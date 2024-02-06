import 'package:ashdod_port_flutter/engine/engine_interface.dart';

abstract class Observable {
  addObserver<T>(Observer<T> observer);
  removeObserver<T>(Observer<T> observer);
  notifyObservers<T>(ARequest<T> value);
}

abstract class Observer<T> {
  List<ARequest> get requests;
  onNotify(ARequest<T> value);
}