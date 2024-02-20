import 'package:ashdod_port_flutter/engine/servers/extensions.dart';
import 'package:ashdod_port_flutter/engine/servers/server.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:observers_manager/observer_response.dart';

import '../../models/day_model.dart';
import '../../models/role_model.dart';


extension ExtractRequest on String {
  Future<Result<T>> performRequest<T>() async {
    switch(this) {
      case 'fetchRoles':
        var result = await FirebaseFirestore.instance
            .collection('roles')
            .orderBy('orderBy', descending: false)
            .get();
        if (result.docs.isEmpty) {
          return Result.error(failure: 'Failed to fetch roles'.error);
        }
        return Result.success(type: 'fetchRoles', success: result.docs.map((e) => RoleModel(map: e.data().cast<String, dynamic>()))
            .toList() as T);
    }
    return Future.value();
  }
}

class FBDataFetcher extends DataFetcher {
  @override
  Future<Result<List<RoleModel>>> fetchRoles() async {
    var roles = await FirebaseFirestore.instance.collection('roles').orderBy('orderBy', descending: false).get();
    if (roles.docs.isEmpty) {
      return Result.error(failure: ErrorModel(title: 'Error', message: 'Failed to fetch roles', actions: ['OK']));
    }
    return Result.success(success: roles.docs.map((e) => RoleModel(map: e.data().cast<String, dynamic>())).toList());
  }

  @override
  Future<Result<bool>> updateUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).set(data);
    return Result.success(success: true);
  }

}

class FBAuth implements Auth {
  @override
  Future<Result<String>> login({required String email, required String password}) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      return Result.success(success: credential.user!.uid);
    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return Result.error(failure: e.code.error);
    }
  }

  @override
  Future<Result<bool>> resetPassword({required String email}) async {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Result.success(success: true);
    } on FirebaseAuthException  catch(e) {
      return Result.error(failure: e.code.error);
    }
  }

  @override
  Future<Result<String>> createAccount({required String email, required String password}) async {
    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password);
      if (value.user == null) {
        return Result.error(failure: ErrorModel(title: 'Account Error', message: 'Failed to create an account', actions: ['OK']));
      } else
      {
        return Result.success(success: value.user?.uid);
      }
    } on FirebaseAuthException catch(e) {
      return Result.error(failure: ErrorModel(title: 'Account Error', message: e.code, actions: ['OK']));
    }
  }

}

class FirebaseHandler implements Server {

  @override
  Auth get authenticator => FBAuth();

  @override
  DataFetcher get fetcher => FBDataFetcher();

}