import 'package:flutter/material.dart';

import '../components/app_buttons.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Stack(
            children: [
              Align(alignment: AlignmentDirectional.bottomStart,
                  child: Image.asset('assets/sign_up_bg.png')),
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 25.0, left: 30.0, right: 30.0),
                  child: Column(
                      children: [
                        Text('Create Account :)', style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                        Spacer(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Enter Email Id', style: TextStyle(fontSize: 22),)),
                        TextField(),
                        //SizedBox(height: 25),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Create Username', style: TextStyle(fontSize: 22),)),
                        TextField(),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Create Password', style: TextStyle(fontSize: 22),)),
                        TextField(),
                        Spacer(),
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

