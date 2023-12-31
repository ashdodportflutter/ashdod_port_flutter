import 'package:flutter/material.dart';
import '../components/app_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
            children: [
              Image.asset('assets/login_page_bg.png'),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30.0, left: 30.0, right: 30.0),
                      child:Column(
                        children: [
                          Text('Welcome Back!'),
                          Text('Enter Your Username & Password'),
                          Text('Username'),
                          TextField(),
                          Text('Password'),
                          TextField(keyboardType: TextInputType.none),
                          LoginButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/get_in');
                            },
                            text: 'Login',),
                          TextButton(child:Text('Forgotten Password?'), onPressed: () {  }, ),
                          TextButton(child:Text('Or Create a New Account'), onPressed: () {
                            Navigator.pushNamed(context, '/create_account');
                          },),
                        ],
                      ))



            ])
        );

  }
}
