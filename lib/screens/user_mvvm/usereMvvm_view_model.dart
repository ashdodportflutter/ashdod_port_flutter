import 'package:ashdod_port_flutter/models/user.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModelMvvm extends AppBaseModel{
  List<AppUser>? users;
  String? hint;
  String? errorSearch;
}
class UserMvvmViewModel extends AppViewModel<UserModelMvvm>{
  UserMvvmViewModel({required super.model}){
    fetchUsers();

  }
  final nameController = TextEditingController();

  void fetchUsers([String? query]) {
    model.isLoading = true;
    notifyObserver();
    engine.server.fetcher.fetchUsers(query).then((value) => {
      if (value.success != null) {
        model.users = value.success,

        model.isLoading = false,
        notifyObserver()
      }
    });
  }
}