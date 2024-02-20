import 'package:ashdod_port_flutter/view_model/app_view_model.dart';

class CreateViewModel extends AppViewModel<AppBaseModel> {
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