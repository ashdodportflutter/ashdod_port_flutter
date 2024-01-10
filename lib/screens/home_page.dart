import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? arrived;
  DateTime? left;

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
      appBar: AppBar(),
      body: Column(
        children:[
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Arrived', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            subtitle: Text(arrived?.timestamp() ?? ''),
            onTap: () {
              setState(() {
                arrived = DateTime.now();
                FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(arrived?.dateKey()).update(
                  { 'arrived': arrived?.millisecondsSinceEpoch}
                );
              });
            },

          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Left',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            subtitle: Text(left?.timestamp() ?? ''),
            onTap: () {
              setState(() {
                left = DateTime.now();
                FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).collection('presence').doc(left?.dateKey()).update(
                    { 'left': left?.millisecondsSinceEpoch}
                );
              });
            },

          )
        ]
        ,),
    );
  }
}
