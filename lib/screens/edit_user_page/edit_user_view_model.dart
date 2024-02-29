import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

class EditUserModel extends AppBaseModel {
  List<RoleModel>? roles;
  RoleModel? selectedRole;
  late DateTime currentDate;

}

class EditUserViewModel extends AppViewModel<EditUserModel> {

  EditUserViewModel({required super.model}) {
    nameController.text = AppUser.instance.name ?? '';
    dutyController.text = AppUser.instance.duty ?? '';
    model.currentDate = AppUser.instance.birthDate ?? DateTime.now();
    dateInput.text = model.currentDate.birthDate();
    fetchRoles();
  }

  final nameController = TextEditingController();
  final dutyController = TextEditingController();
  final dateInput = TextEditingController();


  fetchRoles() {
    model.isLoading = true;
    notifyObserver();
    engine.server.fetcher.fetchRoles().then((value) => {
      if (value.success != null) {
        model.roles = value.success,
        model.selectedRole = model.roles?.first,
        model.isLoading = false,
        notifyObserver()
      }
    });
  }

  set role(RoleModel? role) {
    if (role != null) {
      model.selectedRole = role;
      notifyObserver();
    }
  }

  set date (DateTime? date) {
    if(date != null ){
      print(date);  //pickedDate output format => 2021-03-10 00:00:00.000
      //you can implement different kind of Date Format here according to your requirement
      model.currentDate = date;
      dateInput.text = model.currentDate.birthDate();
      notifyObserver();
    }else{
      print("Date is not selected");
    }
  }

  updateUser() {
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).set(
        {
          'name': nameController.text,
          'role': model.selectedRole?.toJson,
          'duty': dutyController.text,
          'birthDate': model.currentDate.millisecondsSinceEpoch,
          'splittedName': nameController.text.splitToSubStrings
        }
    );

  }
}