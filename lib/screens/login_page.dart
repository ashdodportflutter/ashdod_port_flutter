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
            Align(alignment: AlignmentDirectional.bottomStart, child: Image.asset('assets/login_page_bg.png')),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 25.0, left: 30.0, right: 30.0),
                      child:Column(
                        children: [
                          Text('Welcome Back !', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('Enter Your Username & Password', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                          Spacer(),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Username', style: TextStyle(fontSize: 22),)),
                          TextField(),
                          //SizedBox(height: 25),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text('Password', style: TextStyle(fontSize: 22),)),
                          TextField(),
                          Spacer(),
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
