import 'dart:typed_data';

import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:observers_manager/event_observer.dart';

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
    observe(event: 'authState');
    engine.initialize(server: ServerFactory.createServer(ServerType.firebase));
    model.timeOption = [
      PopUpOption(key: 'arrived', icon: Icon(Icons.login), text: 'Arrived', action: () {
        stamp('arrived', 0);
      }),
      PopUpOption(key: 'left', icon: Icon(Icons.logout), text: 'Logout', action: () {
        stamp('left', 1);
      })
    ];
    // _listener = FirebaseAuth.instance.authStateChanges().listen((event) {
    //
    // });
  }

  @override
  onViewLoaded(data) {
    engine.server.fetcher.fetchPresence().then((value) {
      var data = value.success;

      data?.keys.forEach((e) {
        model.timeOption.firstWhere((element) => element.key == e).timestamp = DateTime.fromMillisecondsSinceEpoch(data[e]);
        model.presence[e] = DateTime.fromMillisecondsSinceEpoch(data[e]);
      });
      notifyObserver();
    });
  }

  // late StreamSubscription<User?> _listener;

  stamp(String key, int index) {
    var now = DateTime.now();
    model.presence[key] = now.millisecondsSinceEpoch;
    engine.server.fetcher.updatePresence(model.presence).then((value) => { notifyObserver() });
    model.timeOption[index].timestamp = now;
  }

  delete(PopUpOption  option) {
    var now = DateTime.now();
    model.presence.remove(option.key);
    engine.server.fetcher.updatePresence(model.presence).then((value) => { notifyObserver() });
    option.timestamp = null;

  }

  uploadImage(CroppedFile? file) {
    file?.readAsBytes().then((value) => {
      engine.server.fetcher.uploadFile(value).then((value) => {
        if (value.success ?? false) {
          notifyObserver()
        }
      })
    });
  }

  logout() {
    engine.server.authenticator.logout();
  }

  @override
  onNotify(ObservedData data) {
    switch(data.event) {
      case 'authState':
        if (data.data == false) {
          model.nextPage = '/login';
          engine.removeObserver(this);
          notifyObserver();
        } else {
          observe(event: 'timestamp');
        }
        break;
      case 'timestamp':
        if (data.data != model.imageTimestamp) {
          model.imageTimestamp = data.data;
          engine.server.fetcher.fetchUserImage().then((value) => {
            model.image = value.success,
            notifyObserver()
          });
        }
        break;
    }
  }
}