import 'package:ashdod_port_flutter/engine/engine.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:observers_manager/observers_manager.dart';

class BaseModel {
  AppUser? user;
  var isLoading = false;
  String? nextPage;
  BaseModel(this.isLoading, {this.user});
}

class ViewModelBase<T extends BaseModel> with ObserverManager<T> {
  final T model;
  var engine = Engine.instance;

  ViewModelBase({required this.model});

}