import 'dart:typed_data';

import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:flutter/material.dart';

import '../../models/popup_menu_option.dart';

class HomePageModel extends AppBaseModel {
  Map<String, dynamic> presence = {};
  late List<PopUpOption> timeOption;
  Uint8List? image;
}

class HomeViewModel extends AppViewModel<HomePageModel> {
  HomeViewModel({required super.model}) {
    model.timeOption = [
      PopUpOption(key: 'arrived', icon: Icon(Icons.login), text: 'Arrived', action: () {
        stamp('arrived', 0);
      }),
      PopUpOption(key: 'left', icon: Icon(Icons.logout), text: 'Logout', action: () {
        stamp('left', 1);
      })
    ];
  }

  @override
  onViewLoaded(dynamic data) {
    engine.server.authenticator.onAuthState = (isLoggedIn) {

    };


    var now = DateTime.now();
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey).get().then((value) {
      setState(() {
        value.data()?.keys.forEach((e) {
          model.timeOption.firstWhere((element) => element.key == e).timestamp = DateTime.fromMillisecondsSinceEpoch(value.data()?[e]);
          model.presence[e] = DateTime.fromMillisecondsSinceEpoch(value.data()?[e]).timestamp();
        });
      });
    });
  }
  }

  stamp(String key, int index) {
    var now = DateTime.now();
    model.presence[key] = now.millisecondsSinceEpoch;
    engine.server.fetcher.updateTime(model.presence).then((value) => {
        model.timeOption[index].timestamp = now,
        notifyObserver()
    });

  }

  delete(PopUpOption  option) {
    var now = DateTime.now();
    model.presence.remove(option.key);
    engine.server.fetcher.updateTime(model.presence).then((value) => {
      option.timestamp = null,
      notifyObserver()
    });
  }
}