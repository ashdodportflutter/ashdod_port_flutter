import 'package:ashdod_port_flutter/view_model/app_view_model.dart';
import 'package:ashdod_port_flutter/view_model/create_account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:observers_manager/base_page.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';



class CreateAccount extends BasePage<CreateViewModel> {
  const CreateAccount({super.key, required super.viewModel});

  @override
  BasePageState<CreateAccount, AppBaseModel> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends BasePageState<CreateAccount, AppBaseModel> {
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
                    widget.viewModel.createAccount(email: _emailTextController.text, password: _passwordTextController.text);
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
