import 'dart:async';
import 'dart:typed_data';

import 'package:ashdod_port_flutter/models/user.dart';
import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../engine/servers/server_factory.dart';
import '../../models/popup_menu_option.dart';
class HomePageModel extends AppBaseModel {
  late List<PopUpOption> timeOption;
  Uint8List? image;
  Timestamp? imageTimestamp;
  Map<String, dynamic> presence = {};
}

class HomeViewModel extends AppViewModel<HomePageModel> {
  HomeViewModel({required super.model}) {
    engine.initialize(server: ServerFactory.createServer(ServerType.firebase));
    model.timeOption = [
      PopUpOption(key: 'arrived', icon: Icon(Icons.login), text: 'Arrived', action: () {
        stamp('arrived', 0);
      }),
      PopUpOption(key: 'left', icon: Icon(Icons.logout), text: 'Logout', action: () {
        stamp('left', 1);
      })
    ];
    _listener = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        model.nextPage = '/login';
        notifyObserver();
      } else {
        FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).snapshots().listen((event) {
          if (event.data()?['timestamp'] != model.imageTimestamp) {
            model.imageTimestamp = event.data()?['timestamp'];
            FirebaseStorage.instance.ref('${FirebaseAuth.instance.currentUser?.uid}.jpeg').getData().then((value) => {
              model.image = value,
              notifyObserver()
            });
          }
        });
        var now = DateTime.now();
        FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey).get().then((value) {
          value.data()?.keys.forEach((e) {
            model.timeOption.firstWhere((element) => element.key == e).timestamp = DateTime.fromMillisecondsSinceEpoch(value.data()?[e]);
            model.presence[e] = DateTime.fromMillisecondsSinceEpoch(value.data()?[e]).timestamp();
          });
          notifyObserver();
        });
      }
    });
  }

  late StreamSubscription<User?> _listener;

  stamp(String key, int index) {
    var now = DateTime.now();
    model.presence[key] = now.millisecondsSinceEpoch;
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey).set(
        model.presence
    );
    model.timeOption[index].timestamp = now;
    notifyObserver();
  }

  delete(PopUpOption  option) {
    var now = DateTime.now();
    model.presence.remove(option.key);
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey).set(
        model.presence
    );
    option.timestamp = null;
    notifyObserver();
  }

  @override
  dispose() {
    _listener.cancel();
  }
}