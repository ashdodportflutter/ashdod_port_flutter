import 'package:ashdod_port_flutter/engine/servers/extensions.dart';
import 'package:ashdod_port_flutter/engine/servers/server.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class FirebaseHandler implements Server {
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
  Future<Result> fetchData<T>({required Request<T> request}) async {
    return request.name.performRequest();
  }

}