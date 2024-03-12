import 'dart:ui';

import 'package:ashdod_port_flutter/screens/base_page.dart';
import 'package:ashdod_port_flutter/screens/user_mvvm/usereMvvm_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/app_text_field.dart';

class UserMvvmPage extends AppBasePage<UserModelMvvm,UserMvvmViewModel>{
  UserMvvmPage({required super.viewModel});
  @override
  AppBasePageState<UserModelMvvm, UserMvvmViewModel, UserMvvmPage> createState() {
    return _UserMvvmPageState();
  }
}

class _UserMvvmPageState extends AppBasePageState<UserModelMvvm, UserMvvmViewModel, UserMvvmPage>  {
    @override
  // TODO: implement body
  Widget get body => Column(
      children: [
        AppTextField(
          text: 'Full Name',
          controller: viewModel.nameController,

          onTextChange: viewModel.fetchUsers,

        ),
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(model.users ?[index].name ?? ''),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey,);
              },
              itemCount: model.users?.length ?? 0),
        ),
      ],
    );
}