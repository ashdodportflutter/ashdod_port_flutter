import 'package:flutter/cupertino.dart';

class PopUpOption {
  final Icon icon;
  final String text;
  String? key;
  final Function()? action;
  DateTime? timestamp;
  
  PopUpOption(
      {
        this.key,
        required this.icon,
        required this.text,
        this.action
      });
}
