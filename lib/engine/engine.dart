import 'package:ashdod_port_flutter/engine/engine_interface.dart';
import 'package:ashdod_port_flutter/engine/servers/server.dart';
import 'package:ashdod_port_flutter/models/role_model.dart';
import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:observers_manager/event_observer.dart';
import 'package:observers_manager/event_obsevable.dart';
import 'package:observers_manager/observer_data.dart';
import 'package:observers_manager/observer_response.dart';
import 'package:observers_manager/observers_manager.dart';

class Engine with EventObservable {
  static final Engine _instance = Engine._();
  static Engine get instance => _instance;
  Engine._();
  late Server server;

  initialize({ required Server server }) {
    this.server = server;
    this.server.authenticator.authState = (isLoggedIn) {
      notifyObservers(ObservedData(event: 'authState', data: isLoggedIn));
    };
    server.fetcher.onTimestampChange = (timestamp) {
      notifyObservers(ObservedData(event: 'timestamp', data: timestamp));
    };
  }

  Future<List<AppUser>?> fetchUsers(RoleModel role) async {
    var users = await FirebaseFirestore.instance.collection('employees').where('role', isEqualTo: role.map).get();
    return users.docs.map((e) => AppUser.fromMap(e.data())).toList();
  }

  Future<List<AppUser>?> fetchUsersByName(String query) async {
    var users = await FirebaseFirestore.instance.collection('employees').where('splittedName', arrayContains: query.toLowerCase()).get();
    return users.docs.map((e) => AppUser.fromMap(e.data())).toList();
  }


  // commitRequest<T>(ObserverData<T> data) {
  //   switch (RequestType.values.byName(data.event)) {
  //
  //     case RequestType.login:
  //       server.login(email: data.arg0, password: data.arg1).then((value) => {
  //         notifyExtract(RequestType.login, value)
  //       });
  //       break;
  //     case RequestType.register:
  //       break;
  //     case RequestType.resetPassword:
  //       server.resetPassword(email: data.arg0).then((value) => {
  //         notifyExtract(RequestType.resetPassword, value)
  //       });
  //       break;
  //     case RequestType.fetchData:
  //       fetchData(data.arg0);
  //       break;
  //     case RequestType.updateUser:
  //       break;
  //   }
  // }
  //
  // fetchData(Request request) {
  //   server.fetchData(request: request).then((value) => {
  //     notifyExtract(RequestType.fetchData, value)
  //   });
  // }
  //
  // notifyExtract<T>(RequestType type, Result result) {
  //   if (result.failure != null) {
  //     notifyObserver(ObserverResponse.error(event: type.name, failure: result.failure));
  //   }  else {
  //     notifyObserver(ObserverResponse.success(dataType: result.type, event: type.name, success: result.success));
  //   }
  // }
  
  appLogin(ObserverData loginData) async {

  }


  register(ObserverData<dynamic> data) {
    // TODO: implement register
    throw UnimplementedError();
  }

  resetPassword([ObserverData<dynamic>? data]) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }


  updateUser(ObserverData request) {
    FirebaseFirestore.instance.collection(request.arg0).doc(request.arg1).get().then((value) {
      AppUser.instance.update(value.data()!.cast<String, dynamic>());
    });
  }
//endregion

}