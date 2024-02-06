import 'package:ashdod_port_flutter/engine/engine_interface.dart';
import 'package:ashdod_port_flutter/engine/observer.dart';
import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Engine implements Observable, BaseEngine {
  static final Engine _instance = Engine._();
  static Engine get instance => _instance;
  Engine._();

  final _observers = <Observer>[];

  Future<List<RoleModel>> fetchRoles() async {
     var roles = await FirebaseFirestore.instance.collection('roles').orderBy('orderBy', descending: false).get();
     return roles.docs.map((e) => RoleModel(map: e.data().cast<String, dynamic>())).toList();
  }
  
  Future<List<AppUser>?> fetchUsers(RoleModel role) async {
    var users = await FirebaseFirestore.instance.collection('employees').where('role', isEqualTo: role.map).get();
    return users.docs.map((e) => AppUser.fromMap(e.data())).toList();
  }

  Future<List<AppUser>?> fetchUsersByName(String query) async {
    var users = await FirebaseFirestore.instance.collection('employees').where('splittedName', arrayContains: query.toLowerCase()).get();
    return users.docs.map((e) => AppUser.fromMap(e.data())).toList();
  }

  //region Observable Interface
  @override
  addObserver<T>(Observer<T> observer) {
    _observers.add(observer);
  }

  @override
  notifyObservers<T>(ARequest<T> value) {
    _observers.where((element) => element.requests.contains(value)).forEach((element) { element.onNotify(value); });
  }

  @override
  removeObserver<T>(Observer<T> observer) {
    _observers.remove(observer);
  }
  //endregion

  //region BaseEngine Interface
  @override
  fetchData(ARequest request) {
    FirebaseFirestore.instance.collection(request.primary).doc(request.secondary).get().then((value) {

    });
  }

  @override
  appLogin(ARequest loginData) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginData.primary,
          password: loginData.secondary);
      loginData.result = AResult.success(success: credential.user!.uid);
      notifyObservers(loginData);
    } on FirebaseAuthException catch(e) {
      loginData.result = AResult.error(failure: e.code);
      notifyObservers(loginData);
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  register(ARequest<dynamic> data) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  resetPassword([ARequest<dynamic>? data]) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  updateUser(ARequest request) {
    FirebaseFirestore.instance.collection(request.primary).doc(request.secondary).get().then((value) {
      AppUser.instance.update(value.data()!.cast<String, dynamic>());
    });
  }
//endregion

}