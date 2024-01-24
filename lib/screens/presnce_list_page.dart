import 'package:ashdod_port_flutter/models/day_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PresenceListPage extends StatefulWidget {
  const PresenceListPage({super.key});

  @override
  State<PresenceListPage> createState() => _PresenceListPageState();
}

class _PresenceListPageState extends State<PresenceListPage> {
  List<DayModel>? days;

  @override
  void initState() {
    super.initState();
    // For observing the resluts online
    FirebaseFirestore.instance
        .collection('employees')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('presence')
        .snapshots()
        .listen((value) {
      setState(() {
        days = value.docs.map((e) => DayModel(e.data())).toList();
      });
    });
    
    // For getting the reslults once
    // FirebaseFirestore.instance
    //     .collection('employees')
    //     .doc(FirebaseAuth.instance.currentUser?.uid)
    //     .collection('presence')
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     days = value.docs.map((e) => DayModel(e.data())).toList();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var day = days?[index];
            return Column(children: [
              SizedBox(
                  height: 30,
                  child: Text(day?.month ?? '',
                      style: TextStyle(fontSize: 22, color: Colors.blue))),
              ListTile(
                leading: Container(
                  padding: EdgeInsets.only(top: 16),
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red,
                      width: 5.0,
                    ),
                  ),
                  child: Text(
                    day?.dayPresent ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Column(children: [
                  Text(
                    '${day?.hourPresentArrived ?? ''} כניסה ',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  Text(
                    '${day?.hourPresentLeft ?? ''} יציאה ',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )
                ]),
                // subtitle: Text(day?.hourPresentLeft ?? ''),
              ),
            ]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 1,
              color: Colors.grey,
            );
          },
          itemCount: days?.length ?? 0),
    );
  }
}
