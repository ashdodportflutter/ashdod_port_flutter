import 'package:ashdod_port_flutter/engine/engine.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:observers_manager/view_model_base.dart';
class AppBaseModel extends BaseModel {
  AppUser? user;

  AppBaseModel(super.isLoading);

}
class AppViewModel<T extends AppBaseModel> extends ViewModelBase<T> {
  var engine = Engine.instance;
  AppViewModel({required super.model});

}