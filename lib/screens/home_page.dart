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
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 60, right: 30, left: 30),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                inputDate(),
                Divider(height: 20,),
                Expanded(child: gridCards(6))
              ],
            )
        ));
  }

  TextField inputDate() {
    return TextField(
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
      onTap: () {
        _selectDate(context);
      },
    );
  }

  GridView gridCards(int _count) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(5.0),
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      children:
      List<Widget>.generate(
          _count,
              (int index) {
                String name = '';
                switch (index) {
                  case 0:
                    name = 'MAROM';
                  case 1:
                    name = 'DOV';
                  case 2:
                    name = 'NIR';
                  case 3:
                    name = 'LIOR';
                  case 4:
                    name = 'ITZIK';
                  case 5:
                    name = 'ROMAN';
                  default:
                    {
                      name = '-';
                    }
                    break;
                }
                return GridTile(
                    child: Card(
                        color: Color(
                            (Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                            .withOpacity(1.0),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          child: Text('\n\n' + name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),),
                          onTap: () {
                            debugPrint('Card tapped.');
                            _showDialogBox(name);
                          },
                        )
                    )
                );
              }

      ),
    );
  }

  _showDialogBox(String msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title:  Text(msg),
            content: const Text('AlertDialog description'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
    );
    //child: const Text('Show Dialog');
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(' ')[0];
      });
    }
  }
}

