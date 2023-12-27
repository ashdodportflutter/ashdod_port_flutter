import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const LoginButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        onPressed: () {
          onPressed.call();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
          child: Text(text, style: TextStyle(fontSize: 30, color: Colors.white),),
        ));
  }
}
