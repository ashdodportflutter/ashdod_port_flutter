import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
   AppTextField({super.key, required this.text, required this.controller, this.onTextChange});
  final String text;
  final TextEditingController controller;
  final Function(String)? onTextChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,10,50,0),
      child:
      Column(
        children: [
          Align(alignment: Alignment.topLeft, child: Text(text,style: TextStyle(fontSize: 16))),
          TextField(
            controller: controller,
            onChanged:onTextChange,
            decoration: InputDecoration(

              prefixIcon: IconButton(
                icon:
                const Icon(Icons.cancel, color: Colors.blue),
                onPressed: () => {
                  controller.clear()
                  // log('hi')
                },
              ),
            )),

        ]
      ),
    );
  }
}
