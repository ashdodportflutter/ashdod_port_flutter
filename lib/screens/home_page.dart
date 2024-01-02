import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
           body:  inputDate(),
        );
  }

  Widget inputDate() {
    return
      Padding(
        padding: const EdgeInsets.only(top: 80, right: 30, left: 30),
        child: TextField(
          decoration: const InputDecoration(
            labelText: 'DATE',
            filled: true,
            prefixIcon: Icon(Icons.calendar_today),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)
            ),
          ),
          controller: _dateController,
          readOnly: true,
          onTap:() {
            _selectDate(context);
          },
        ),
      );

  }

  Future<void> _selectDate(BuildContext context) async{
     DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
     );
     if(_picked != null)
       {
         setState(() {
           _dateController.text= _picked.toString().split(' ')[0];
         });
       }
  }
}
