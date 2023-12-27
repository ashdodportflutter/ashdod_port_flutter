import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String Label;
  final TextField TF;

  const TextFields({super.key, required this.Label, required this.TF});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Align(alignment: Alignment.centerLeft,child: Text(Label,style: TextStyle(fontSize: 25),)),
      TF,]);
  }
}
