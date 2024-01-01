import 'package:flutter/material.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _passwordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return Align(
      alignment: Alignment.center,
      child: Stack(children: [
        Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('assets/login_page_bg.png')),
        Column(
          children: [
            showWellCome(),
            showLitleText(),
            Spacer(),
            AppTextField(

              text: 'User Name',
              controller: _usernameTextController,
            ),
            AppTextField(

              text: 'Password',
              controller: _passwordTextController,
            ),
            Spacer(flex: 1,),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(children: [
                    LoginButton(
                      onPressed: () {
                        print(_passwordTextController.text);
                        print(_usernameTextController.text);
                        //Navigator.pushNamed(context, '/login');
                      },
                      text: 'Login',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: InkWell(
                        child: Text("forget Password"),
                        onTap: () {print("forget Password");},
                      ),
                    ), Padding(
                      padding: EdgeInsets.only(bottom: 30),
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
      ]),
    );
  }

  showWellCome() {
    return Text(
      'Welcome Back!',
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }

  showLitleText() {
    return Text(
      'Enter Your UserName & Password',
      style: TextStyle(fontSize: 20),
    );
  }
}
