import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _passwordTextController = TextEditingController(text: 'passw0rd');
  final _usernameTextController = TextEditingController(text: 'nissopa@gmail.com');
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [],
      ),
      body: getBody(),
    );
  }

  getBody() {
    return Stack(children: [
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
          Spacer(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(children: [
                  LoginButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: _usernameTextController.text,
                            password: _passwordTextController.text).then((
                            value) {
                          if (value.user != null) {
                            FirebaseFirestore.instance.collection('employees').doc(value.user?.uid).get().then((value) => {
                              AppUser.instance.update(value.data()!.cast<String, dynamic>())
                            });
                            setState(() {
                              isLoading = false;
                            });
                            print(value.user?.email ?? 'no email');
                            Navigator.pushNamed(context, '/home_page');
                          }
                        });
                      } on FirebaseAuthException catch(e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                      //Navigator.pushNamed(context, '/login');
                    },
                    text: 'Login',
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: InkWell(
                      child: Text("forget Password"),
                      onTap: () {
                        notifyResetPassword();
                        FirebaseAuth.instance.sendPasswordResetEmail(email: _usernameTextController.text);
                        print("forget Password");
                        },
                    ),
                  ), Padding(
                    padding: EdgeInsets.only(bottom: 10),
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
      getLoader(isLoading)
    ]);
  }

  showWellCome() {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          'Welcome Back!',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  showLitleText() {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'Enter Your UserName & Password',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }

  notifyResetPassword() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        content: Text('We sent you an email for restoring your password'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text('OK'))
        ],
      );
    });
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
