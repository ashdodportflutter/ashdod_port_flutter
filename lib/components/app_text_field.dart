import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({super.key, required this.onPressed, required this.text, required this.controller});
  final Function() onPressed;
  final String text;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,20,50,0),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            prefixIcon: IconButton(
              icon:
              const Icon(Icons.cancel, color: Colors.blue),
              onPressed: () => {
                controller.clear()
                // log('hi')
              },
            ),
          )),
    );
  }
}
