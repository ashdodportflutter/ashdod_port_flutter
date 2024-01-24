import 'package:flutter/material.dart';

import '../models/role_model.dart';

class RolePicker extends StatefulWidget {
  final List<RoleModel> roles;
  final Function(RoleModel?) onPick;
  const RolePicker({super.key, required this.roles, required this.onPick});

  @override
  State<StatefulWidget> createState() => _RolePickerState();
}

class _RolePickerState extends State<RolePicker> {
  RoleModel? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<RoleModel>(
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
        widget.onPick.call(value);
        setState(() {
          dropdownValue = value;
        });
      },
      items: widget.roles.map<DropdownMenuItem<RoleModel>>((RoleModel value) {
        return DropdownMenuItem<RoleModel>(
          value: value,
          child: Text(value.name ?? ''),
        );
      }).toList(),
    );
  }
}
