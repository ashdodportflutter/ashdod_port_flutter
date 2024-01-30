import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Engine {
  static final Engine _instance = Engine._();
  static Engine get instance => _instance;
  Engine._();

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

  // Future<bool> addUser()

}