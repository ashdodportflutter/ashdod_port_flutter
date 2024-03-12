
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:ashdod_port_flutter/screens/base_page.dart';
import 'package:ashdod_port_flutter/screens/edit_user_page/edit_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:observers_manager/view_model_base.dart';
import '../../components/app_buttons.dart';
import '../../components/app_text_field.dart';
import '../../models/role_model.dart';

class EditUserPage extends AppBasePage<EditUserModel, EditUserViewModel> {
  EditUserPage({required super.viewModel});


  @override
  AppBasePageState<EditUserModel, EditUserViewModel, EditUserPage> createState() {
    return _EditUserPageState();
  }
}

class _EditUserPageState extends AppBasePageState<EditUserModel, EditUserViewModel, EditUserPage>  {


  Widget getDate() {
    return Container(
      padding: EdgeInsets.all(25),
      child: TextField(
        controller: viewModel.dateInput, //editing controller of this TextField
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Enter Date" //label text of field
        ),
        readOnly: true,  //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context, initialDate: model.currentDate,
              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
              lastDate:  DateTime.now()
          );

          viewModel.date = pickedDate;
        },
      ),
    );
  }

  @override
  Widget get body => Column(
    children: [
      AppTextField(
        text: 'Full Name',
        controller: viewModel.nameController,
      ),
      AppTextField(
        text: 'Duty',
        controller: viewModel.dutyController,
      ),
      DropdownButton<RoleModel>(
        hint: Text('Pick A Role'),
        value: model.selectedRole,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (RoleModel? value) {
          // This is called when the user selects an item.
          viewModel.role = value;
        },
        items: model.roles?.map<DropdownMenuItem<RoleModel>>((RoleModel value) {
          return DropdownMenuItem<RoleModel>(
            value: value,
            child: Text(value.name ?? ''),
          );
        }).toList(),
      ),
      getDate(),
      LoginButton(
          onPressed: viewModel.updateUser,
          text: 'Submit')
    ],
  );
}
