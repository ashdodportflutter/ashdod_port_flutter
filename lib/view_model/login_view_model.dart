



import 'package:ashdod_port_flutter/view_model/app_view_model.dart';

class LoginViewModel extends AppViewModel<AppBaseModel> {
  LoginViewModel({required super.model});

  login({required String email, required String password}) {
    model.isLoading = true;
    notifyObserver(model);
    engine.server.authenticator.login(email: email, password: password).then((value) => {
      if (value.failure != null) {
        // handle failure
      } else if (value.success != null) {
        model.isLoading = false,
        model.nextPage = '/homa_page',
        notifyObserver(model)
      }
    });
  }

  resetPassword(String email) {
    model.isLoading = true;
    notifyObserver();
    engine.server.authenticator.resetPassword(email: email).then((value) => {
      model.isLoading = false,
      model.nextPage = null,
      notifyObserver(model)
    });
  }
}