import 'package:flutter/material.dart';
import 'package:ashdod_port_flutter/components/app_buttons.dart';

import '../components/app_textFields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(alignment: Alignment.bottomCenter,child: Image.asset('assets/login_page_bg.png')),
          Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 30.0, left: 30.0, right: 30.0),
            child: Column(
              children: [
                Align(alignment: Alignment.centerLeft,child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                [
                  Text('Welcome back!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  Text('Enter your username & password', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                ],
                )
                ),
                Spacer(),

                TextFields(Label: "Username",TF: TextField()),
                Padding(padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 30.0, right: 30.0)),
                TextFields(Label: "Password",TF: TextField()),
                Padding(padding: const EdgeInsets.only(top: 50.0, bottom: 30.0, left: 30.0, right: 30.0)),

                Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 15),
                    child: LoginButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      text: 'Login',)
                ),
                Align(alignment: Alignment.center,child: Text('Forgotten Password', style: TextStyle(fontSize: 15,color: Colors.grey))),
                Align(alignment: Alignment.center,child: Text('Or Create A New Account',style: TextStyle(fontSize: 15,color: Colors.grey))),
                Padding(padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 30.0, right: 30.0)),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
