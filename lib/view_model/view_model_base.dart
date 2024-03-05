

import 'package:observers_manager/event_observer.dart';
import 'package:observers_manager/view_model_base.dart';

import '../engine/engine.dart';
import '../models/user.dart';

class AppBaseModel extends BaseModel {
  AppUser? user;
}

class AppViewModel<T extends BaseModel> extends ViewModelBase<T> with EventObserver {

  var engine = Engine.instance;

  AppViewModel({required super.model}) {
    engine.addObserver(this);
  }

  @override
  dispose() {
    engine.removeObserver(this);
    super.dispose();
  }
}