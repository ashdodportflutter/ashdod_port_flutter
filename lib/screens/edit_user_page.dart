import 'dart:async';

import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';
import '../models/role_model.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _nameController = TextEditingController();
  final _dutyController = TextEditingController();
  final dateinput = TextEditingController();
  late DateTime currentDate;
  List<RoleModel>? roles;
  RoleModel? dropdownValue;

  @override
  void initState() {
    super.initState();
    _nameController.text = AppUser.instance.name ?? '';
    _dutyController.text = AppUser.instance.duty ?? '';
    currentDate = AppUser.instance.birthDate ?? DateTime.now();
    dateinput.text = currentDate.birthDate();
    FirebaseFirestore.instance
        .collection('roles')
        .orderBy('orderBy', descending: false)
        .get().then((event) {
      setState(() {
        roles = event.docs
            .map((e) => RoleModel(map: e.data().cast<String, dynamic>()))
            .toList();
        dropdownValue = roles?.firstWhere((element) => element.id == dropdownValue?.id);
        // dropdownValue = AppUser.instance.role ?? roles?.first;
      });
    });
  }

  Widget getDate() {
    return Container(
      padding: EdgeInsets.all(25),
      child: TextField(
        controller: dateinput, //editing controller of this TextField
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Enter Date" //label text of field
        ),
        readOnly: true,  //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context, initialDate: currentDate,
              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
              lastDate:  DateTime.now()
          );

          if(pickedDate != null ){
            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
            //you can implement different kind of Date Format here according to your requirement
            currentDate = pickedDate;
                setState(() {
              dateinput.text = currentDate.birthDate(); //set output date to TextField value.
            });
          }else{
            print("Date is not selected");
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Employee Form'),
      ),
      body: Column(
        children: [
          AppTextField(
            text: 'Full Name',
            controller: _nameController,
          ),
          AppTextField(
            text: 'Duty',
            controller: _dutyController,
          ),
          DropdownButton<RoleModel>(
            hint: Text('Pick A Role'),
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (RoleModel? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value;
              });
            },
            items: roles?.map<DropdownMenuItem<RoleModel>>((RoleModel value) {
              return DropdownMenuItem<RoleModel>(
                value: value,
                child: Text(value.name ?? ''),
              );
            }).toList(),
          ),
          getDate(),
          LoginButton(
              onPressed: () {
                print(FirebaseAuth.instance.currentUser?.uid ?? '');
                FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).set(
                    {
                      'name': _nameController.text,
                      'role': dropdownValue?.toJson,
                      'duty': _dutyController.text,
                      'birthDate': currentDate.millisecondsSinceEpoch,
                      'splittedName': _nameController.text.splitToSubStrings
                    }
                );
              },
              text: 'Submit')
        ],
      ),
    );
  }
}
