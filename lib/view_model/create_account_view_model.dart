import 'package:ashdod_port_flutter/view_model/view_model_base.dart';

class CreateViewModel extends ViewModelBase<BaseModel> {
  CreateViewModel({required super.model});

  createAccount({required String email, required String password}) {
    model.isLoading = true;
    notifyObserver();
    engine.server.authenticator.createAccount(email: email, password: password).then((value) => {
      model.isLoading = false,
      notifyObserver(model)
    });
  }
}