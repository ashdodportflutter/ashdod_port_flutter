import 'package:flutter/material.dart';
import '../components/app_buttons.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _emailTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
            children: [
              Align(alignment: AlignmentDirectional.centerStart,
                  child: Image.asset('assets/sign_up_bg.png')),
              Padding(
                  padding: const EdgeInsets.only(
                       top: 2, bottom: 12.0, left: 30.0, right: 30.0),
                  child: Column(
                      children: [
                        Spacer(),
                        Text('Create Account :)', style: TextStyle(
                            fontSize: 38, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Enter Email Id', style: TextStyle(fontSize: 22),)),
                        TextField(controller: _emailTextController,),
                        Spacer(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Create Username', style: TextStyle(fontSize: 22),)),
                        TextField(controller: _usernameTextController,),
                        Spacer(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Create Password', style: TextStyle(fontSize: 22),)),
                        TextField(controller: _passwordTextController,),
                        Spacer(),
                        //SizedBox(height: 10,),
                        LoginButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          text: 'Sign Up',),
                      ]
                  )
              ),
            ]
        )
    );
  }
}

