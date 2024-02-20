import 'package:ashdod_port_flutter/screens/base_page.dart';
import 'package:ashdod_port_flutter/view_model/login_view_model.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:flutter/material.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';

class LoginPage extends BasePage<LoginViewModel> {
  const LoginPage({super.key, required super.viewModel});

  @override
  State<BasePage<LoginViewModel>> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BasePageState<LoginPage, BaseModel> {
  final _passwordTextController = TextEditingController(text: 'Ntnhbhxu10');
  final _usernameTextController = TextEditingController(text: 'nissopa@gmail.com');

  Widget get body {
    return Stack(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset('assets/login_page_bg.png')),
      Column(
        children: [
          showWellCome(),
          showLittleText(),
          Spacer(),
          AppTextField(

            text: 'User Name',
            controller: _usernameTextController,
          ),
          AppTextField(
            text: 'Password',
            controller: _passwordTextController,
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(children: [
                  LoginButton(
                    onPressed: () {
                      widget.viewModel.login(email: _usernameTextController.text, password: _passwordTextController.text);
                    },
                    text: 'Login',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: Text("forget Password"),
                      onTap: () {
                        notifyResetPassword();
                        // Engine.instance.commitRequest(addTopic(ObserverData.withArgs(event: RequestType.resetPassword.name, arg0: _usernameTextController.text)));
                        print("forget Password");
                      },
                    ),
                  ), Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      child: Text("Or Create new Account"),
                      onTap: () {
                        Navigator.pushNamed(context, '/create_account');
                      },
                    ),
                  )
                  ,

                ]),
              ))
        ],
      ),
    ]);
  }



  showWellCome() {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          'Welcome Back!',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  showLittleText() {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'Enter Your UserName & Password',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  notifyResetPassword() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        content: Text('We sent you an email for restoring your password'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('OK'))
        ],
      );
    });
  }

  @override
  onNotify([BaseModel? data]) {
    super.onNotify(data);
    if (data?.nextPage != null) {
      Navigator.pushReplacementNamed(context, data?.nextPage ?? '');
    } else {
      notifyResetPassword();
    }
  }

  // @override
  // onNotify(BaseModel data) {
  //   // setState(() {
  //   //
  //   // });
  // //   super.onNotify(value);
  // //   setState(() {
  // //     isLoading = false;
  // //   });
  // //   if (value.failure != null) {
  // //     showDialog(context: context, builder: (context) {
  // //       return AlertDialog(
  // //         title: Text(value.failure?.title ?? ''),
  // //         content: Text(value.failure?.message ?? ''),
  // //         actions: [
  // //           ElevatedButton(
  // //               onPressed: () {
  // //                 Navigator.pop(context);
  // //                 // Engine.instance.commitRequest(addTopic(ObserverData.withArgs(event: RequestType.login.name, arg0: _usernameTextController.text, arg1: _passwordTextController.text)));
  // //               },
  // //               child: Text(value.failure?.actions.first ?? '')),
  // //           ElevatedButton(onPressed: () {
  // //             Navigator.pop(context);
  // //           }, child: Text(value.failure?.actions.last ?? ''))
  // //         ],
  // //       );
  // //     });
  // //   } else {
  // //     Navigator.pushReplacementNamed(context, '/home_page');
  // //   }
  // }
}
