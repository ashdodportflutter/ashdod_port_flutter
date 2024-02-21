

import 'package:observers_manager/view_model_base.dart';

import '../engine/engine.dart';
import '../models/user.dart';

class AppBaseModel extends BaseModel {
  AppUser? user;
}

class AppViewModel<T extends BaseModel> extends ViewModelBase<T> {

  var engine = Engine.instance;

  AppViewModel({required super.model});
}