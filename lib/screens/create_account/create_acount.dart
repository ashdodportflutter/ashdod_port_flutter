import 'package:ashdod_port_flutter/screens/base_page.dart';
import 'package:ashdod_port_flutter/screens/create_account/create_account_view_model.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:flutter/material.dart';

import '../../components/app_buttons.dart';
import '../../components/app_text_field.dart';



class CreateAccount extends AppBasePage<AppBaseModel, CreateViewModel> {
  CreateAccount({required super.viewModel});



  @override
  AppBasePageState<AppBaseModel, CreateViewModel, CreateAccount> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends AppBasePageState<AppBaseModel, CreateViewModel, CreateAccount> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool isLoading = false;


  Widget get body {
    return Stack(
        children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset('assets/sign_up_bg.png')),
      Column(
        children: [
          showWellCome(),

          Spacer(),
          AppTextField(

            text: 'Enter Email Id',
            controller: _emailTextController,
          ),
          AppTextField(

            text: 'Create Password',
            controller: _passwordTextController,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(children: [
              Padding(

                padding:EdgeInsets.only(bottom: 50),
                child: LoginButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    viewModel.createAccount(email: _emailTextController.text, password: _passwordTextController.text);
                  },
                  text: 'Sign Up',
                ),
              ),
            ]),
          )
        ],
      )
    ]);
  }

  showWellCome() {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          'Create Account :)',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  @override
  onNotify([AppBaseModel? data]) {
    super.onNotify(data);
    if (data != null) {
      Navigator.pushReplacementNamed(context, '/home_page');
    }
  }
}
