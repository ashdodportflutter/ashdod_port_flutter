import 'package:ashdod_port_flutter/components/role_picker.dart';
import 'package:ashdod_port_flutter/engine/engine.dart';
import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

enum FilterType {
  filter, search, all
}

class _UsersPageState extends State<UsersPage> {


  List<RoleModel>? roles;
  List<AppUser>? users;
  Set<bool> filterState = {false};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users'), actions: [
        SegmentedButton<bool>(
          onSelectionChanged: (selection) {
            setState(() {
              filterState = selection;
            });
          },
            segments: [
          ButtonSegment<bool>(
              value: true,
              label: Text('Filter'),
              icon: Icon(Icons.filter_alt_rounded)),
          ButtonSegment<bool>(
              value: false,
              label: Text('Search'),
              icon: Icon(Icons.search))
        ], selected: filterState)
      ],),
      body: Column(
        children: [
          filterState.first ? Container() : Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(decoration: InputDecoration(hintText: 'Search Query'), onChanged: (text) {
              Engine.instance.fetchUsersByName(text).then((value) => setState(() {users = value;}));
            },),
          ),
          !filterState.first ? Container() : RolePicker(roles: roles!, onPick: (role) {
            if (role != null) {
              Engine.instance.fetchUsers(role).then((value) => setState(() {users = value;}));
            }
          },),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users?[index].name ?? ''),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: Colors.grey,);
                },
                itemCount: users?.length ?? 0),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Engine.instance.server.fetcher.fetchRoles().then((value) => {
      roles = value.success
    });
  }
}
