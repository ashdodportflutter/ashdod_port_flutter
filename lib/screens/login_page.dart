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
              onPressed: () {},
              text: 'User Name',
              controller: _usernameTextController,
            ),
            AppTextField(
              onPressed: () {},
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
                        Navigator.pushNamed(context, '/login');
                      },
                      text: 'Login',
                    ),
                    TextButton(
                        onPressed: () {}, child: Text('forget Password')),
                    TextButton(
                        onPressed: () {}, child: Text('Or Create new Account'))
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
