import 'dart:async';

import 'package:ashdod_port_flutter/view_model/view_model_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/day_model.dart';

class PresenceModel extends AppBaseModel {
  List<DayModel>? days;
}

class PresenceViewModel extends AppViewModel<PresenceModel> {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _listener;

  PresenceViewModel({required super.model}) {
    _listener = FirebaseFirestore.instance
        .collection('employees')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('presence')
        .snapshots()
        .listen((value) {
      model.days = value.docs.map((e) => DayModel(e.data())).toList();
      notifyObserver();
    });
  }

  @override
  dispose() {
    _listener?.cancel();
  }

}