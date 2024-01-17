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
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').get().then((value) {
      setState(() {
        days = value.docs.map((e) => DayModel(e.data())).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.separated(
          itemBuilder: (context, index) {
            var day = days?[index];
            return ListTile(
              leading: Text(day?.day ?? ''),
              title: Text(day?.arrived ?? ''),
              subtitle: Text(day?.left ?? ''),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(thickness: 1, color: Colors.grey,);
          },
          itemCount: days?.length ?? 0),
    );
  }
}
