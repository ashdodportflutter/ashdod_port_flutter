import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:observers_manager/observer.dart';
import 'package:observers_manager/view_model_base.dart';



class LoginViewModel extends AppViewModel<AppBaseModel> {
  LoginViewModel({required super.model});

  login({required String email, required String password}) {
    model.isLoading = true;
    notifyObserver(model);
    engine.server.authenticator.login(email: email, password: password).then((value) => {
      if (value.failure != null) {
        notifyAlert(AlertModel(
            title: 'Error',
          body: 'Check you password',
          actions: [
            AlertAction(
                title: 'OK',
                onTap: () {
                  notifyNavigate(NavigateModel(routeName: ''));
                  model.isLoading = false;
                  notifyObserver(model);
                })
          ]
        ))
      } else if (value.success != null) {
        model.isLoading = false,
        notifyObserver(),
        notifyNavigate(NavigateModel(routeName: '/home_page'))
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