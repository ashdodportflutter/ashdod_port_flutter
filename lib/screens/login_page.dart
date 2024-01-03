import 'package:firebase_auth/firebase_auth.dart';
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
            Spacer(
              flex: 1,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(children: [
                    LoginButton(
                      onPressed: () {
                        print(_passwordTextController.text);
                        print(_usernameTextController.text);
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _usernameTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          if (value.user != null) {
                            print(value.user?.email);
                          }
                        });
                        //Navigator.pushNamed(context, '/login');
                      },
                      text: 'Login',
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: InkWell(
                        child: Text("forget Password"),
                        onTap: () {
                          print("forget Password");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: InkWell(
                        child: Text("Or Create new Account"),
                        onTap: () {
                          Navigator.pushNamed(context, '/create_account');
                        },
                      ),
                    ),
                  ]),
                ))
          ],
        ),
        getLoader(true)
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

}
