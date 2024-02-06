import 'package:ashdod_port_flutter/engine/engine_interface.dart';

abstract class Observable {
  addObserver<T>(Observer<T> observer);
  removeObserver<T>(Observer<T> observer);
  notifyObservers<T>(AResult<T> value);
}

abstract class Observer<T> {
  Type get generic;
  onNotify(AResult<T> value);
}