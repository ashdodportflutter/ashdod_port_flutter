import 'package:ashdod_port_flutter/engine/engine.dart';
import 'package:ashdod_port_flutter/engine/engine_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:observers_manager/observer_data.dart';
import 'package:observers_manager/observer_response.dart';
import 'package:observers_manager/observers_manager.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BaseObserver {
  final _passwordTextController = TextEditingController(text: 'Ntnhbhxu10');
  final _usernameTextController = TextEditingController(text: 'nissopa@gmail.com');
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    Engine.instance.addObserver(this);
  }

  @override
  void dispose() {
    Engine.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [],
      ),
      body: getBody(),
    );
  }

  getBody() {
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
                      setState(() {
                        isLoading = true;
                      });
                      Engine.instance.commitRequest(addTopic(ObserverData.withArgs(event: RequestType.login.name, arg0: _usernameTextController.text, arg1: _passwordTextController.text)));
                    },
                    text: 'Login',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: Text("forget Password"),
                      onTap: () {
                        notifyResetPassword();
                        Engine.instance.commitRequest(addTopic(ObserverData.withArgs(event: RequestType.resetPassword.name, arg0: _usernameTextController.text)));
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
      getLoader(isLoading)
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

  Widget getLoader(misloading) {
    return Visibility(
      visible: misloading,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black45,
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Loading...',
              style: TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }

  @override
  onNotify<T>(ObserverResponse<T> value) {
    super.onNotify(value);
    if (value.failure != null) {
      print('Failed login');
    } else {

      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacementNamed(context, '/home_page');
    }
  }
}
