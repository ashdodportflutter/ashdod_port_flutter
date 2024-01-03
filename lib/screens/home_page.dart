import 'dart:math';

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
           body: inputDate(),
           //endDrawer: gridCards(4) ,

                   //inputDate(),



    );


  }

  Padding inputDate() {
    return
      Padding(
        padding: const EdgeInsets.only(top: 50, right: 30, left: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            TextField(
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
            Expanded(
              child: gridCards(4),

            )
          ],
        )


      );
  }

  GridView gridCards(int _count) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        children:
        List<Widget>.generate(
          _count,
              (int index) {
            return GridTile(
              child: Card(
                color:
                Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                    .withOpacity(1.0),
              ),
            );
          },
        ));
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
