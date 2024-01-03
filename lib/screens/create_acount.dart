import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccount> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();
  bool isLoading = true;

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
            child: Image.asset('assets/sign_up_bg.png')),
        Column(
          children: [
            showWellCome(),
            Spacer(),

            AppTextField(
              text: 'Create User Name',
              controller: _emailTextController,
            ),
            AppTextField(
              text: 'Create Password',
              controller: _passwordTextController,
            ),
            Spacer(
              flex: 1,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: LoginButton(
                        onPressed: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) => {
                                    setState(() {
                                      if(value.user==null)
                                        {

                                        }
                                      else
                                        {

                                        }
                                    })
                                  });
                          //Navigator.pushNamed(context, '/login');
                        },
                        text: 'Sign Up',
                      ),
                    ),
                  ]),
                ))
          ],
        ),
      ]),
    );
  }

  showWellCome() {
    return Text(
      'Create Account :)',
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}
