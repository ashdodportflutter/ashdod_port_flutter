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
  bool isLoading = false;

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
    return Stack(
        children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset('assets/sign_up_bg.png')),
      Column(
        children: [
          showWellCome(),

          Spacer(),
          AppTextField(

            text: 'Enter Email Id',
            controller: _emailTextController,
          ),
          AppTextField(

            text: 'Create Password',
            controller: _passwordTextController,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(children: [
              Padding(

                padding:EdgeInsets.only(bottom: 50),
                child: LoginButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text).then((value) => {
                          if (value.user == null) {
                            // error
                          } else
                            {
                              setState(() {
                                isLoading = false;
                              }),
                              Navigator.pushNamed(context, 'main_page')
                            }
                    });
                  },
                  text: 'Sign Up',
                ),
              ),




            ]),
          )
        ],
      ),
      getLoader(isLoading)
    ]);
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

  showWellCome() {
    return Text(
      'Create Account :)',
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }


}
