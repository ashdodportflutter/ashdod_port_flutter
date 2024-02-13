import 'package:ashdod_port_flutter/engine/server.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      return Result.error(failure: e.code);
    }
  }

  @override
  Future<Result<bool>> resetPassword({required String email}) async {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Result.success(success: true);
    } on FirebaseAuthException  catch(e) {
      return Result.error(failure: e.code);
    }
  }

}