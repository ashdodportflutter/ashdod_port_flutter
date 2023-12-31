import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(),
    body: Stack(
    children: [
     Align(alignment: AlignmentDirectional.bottomStart, child: Image.asset('assets/sign_up_bg.png')),
      ]
    )
    );

  }
}
