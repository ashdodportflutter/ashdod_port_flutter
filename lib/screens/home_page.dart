import 'dart:async';

import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/popup_menu_option.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<PopUpOption> timeOption;
  late StreamSubscription<User?> _listener;

  Map<String, dynamic> presence = {};

  stamp(String key, int index) {
    var now = DateTime.now();
    presence[key] = now.millisecondsSinceEpoch;
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey()).set(
        presence
    );
    setState(() {
      timeOption[index].timestamp = now;
    });
  }

  delete(PopUpOption  option) {
    var now = DateTime.now();
    presence.remove(option.key);
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey()).set(
        presence
    );
    setState(() {
      option.timestamp = null;
    });
  }


  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listener = FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        var now = DateTime.now();
        FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(now.dateKey()).get().then((value) {
          setState(() {
            value.data()?.keys.forEach((e) {
              timeOption.firstWhere((element) => element.key == e).timestamp = DateTime.fromMillisecondsSinceEpoch(value.data()?[e]);
              presence[e] = DateTime.fromMillisecondsSinceEpoch(value.data()?[e]).timestamp();
            });
          });
        });
      }
    });
    timeOption = [
      PopUpOption(key: 'arrived', icon: Icon(Icons.login), text: 'Arrived', action: () {
        stamp('arrived', 0);
      }),
      PopUpOption(key: 'left', icon: Icon(Icons.logout), text: 'Logout', action: () {
        stamp('left', 1);
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('assets/girl1.jpeg'),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.pop(context),
                    Navigator.pop(context)
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit User'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/edit_user_page');
                },
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list');
              },
              icon: Icon(Icons.list))
        ],
      ),
      body: Column(
        children: timeOption.map<Widget>((option) {
          return ListTile(
            leading: option.icon,
            trailing: PopupMenuButton<PopUpOption>(
              itemBuilder: (BuildContext context) {
                var moreOptions = [
                  PopUpOption(icon: Icon(Icons.delete), text: 'Delete'),
                  PopUpOption(icon: Icon(Icons.edit), text: 'Edit'),
                ];
                return moreOptions.map((e) => PopupMenuItem<PopUpOption>(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        delete(option);
                      },
                      child: Row(children: [e.icon, Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(e.text),
                      )],),
                    )
                )).toList();
              },),
            title: Text(option.text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            subtitle: Text(option.timestamp?.timestamp() ?? ''),
            onTap: option.timestamp != null ? null : option.action

          );
        }).toList()
        ,),
    );
  }
}
