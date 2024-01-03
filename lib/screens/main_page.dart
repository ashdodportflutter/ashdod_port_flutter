import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/app_buttons.dart';
import '../components/app_text_field.dart';
import '../models/role_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _nameController = TextEditingController();
  final _dutyController = TextEditingController();
  List<RoleModel>? roles;
  RoleModel? dropdownValue;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('roles')
        .orderBy('orderBy', descending: false)
        .snapshots()
        .listen((event) {
      setState(() {
        roles = event.docs
            .map((e) => RoleModel(e.data().cast<String, dynamic>()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                dropdownValue = value!;
              });
            },
            items: roles?.map<DropdownMenuItem<RoleModel>>((RoleModel value) {
              return DropdownMenuItem<RoleModel>(
                value: value,
                child: Text(value.name ?? ''),
              );
            }).toList(),
          ),
          LoginButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('employees').add({
                  'name': _nameController.text,
                  'role': dropdownValue?.name,
                  'duty': _dutyController.text
                }).then((value) => {

                });
              },
              text: 'Submit')
        ],
      ),
    );
  }
}
