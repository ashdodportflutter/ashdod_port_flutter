import 'package:flutter/material.dart';

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
                      ]
                  )
              ),
            ]
        )
    );
  }
}

