import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';

class EditUserModel extends BaseModel {
  List<RoleModel>? roles;
  RoleModel? selectedRole;

  EditUserModel(super.isLoading);
}

class EditUserViewModel extends ViewModelBase<EditUserModel> {
  EditUserViewModel({required super.model});

  fetchRoles() {
    model.isLoading = true;
    notifyObserver();
    engine.server.fetcher.fetchRoles().then((value) => {
      if (value.success != null) {
        model.roles = value.success,
        model.selectedRole = model.roles?.first,
        model.isLoading = false,
        notifyObserver()
      }
    });
  }

  updateUser(Map<String ,dynamic> data) {

  }
}