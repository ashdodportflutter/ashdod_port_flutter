import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:ashdod_port_flutter/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/popup_menu_option.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<PopUpOption> timeOption;
  late StreamSubscription<User?> _listener;
  Uint8List? image;
  Timestamp? imageTimestamp;

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
    FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).snapshots().listen((event) {
      if (event.data()?['timestamp'] != imageTimestamp) {
        imageTimestamp = event.data()?['timestamp'];
        FirebaseStorage.instance.ref('${FirebaseAuth.instance.currentUser?.uid}.jpeg').getData().then((value) => {
        setState(() {
          image = value;
        })
      });
      }
    });
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
            DrawerHeader(child:
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<ImageSource>(
                    constraints: BoxConstraints(maxHeight: 300),
                    useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                              child: Align(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close)
                                ),
                                alignment: Alignment.topRight,
                              ),
                            ),
                            Center(child: Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Text('Add an Image'),
                            )),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context, ImageSource.camera);
                              },
                              leading: Icon(Icons.camera_alt_outlined),
                              title: Text('Take A Photo'),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context, ImageSource.gallery);
                              },
                              leading: Icon(Icons.photo_album_outlined),
                              title: Text('Pick A Photo'),
                            ),
                          ],
                        );
                  }).then((value) => {
                    if (value != null) {
                      ImagePicker().pickImage(source: value).then((file) {
                        ImageCropper().cropImage(
                            sourcePath: file!.path,
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.ratio3x2,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio4x3,
                              CropAspectRatioPreset.ratio16x9
                            ],
                            uiSettings: [
                              AndroidUiSettings(
                                  toolbarTitle: 'Cropper',
                                  toolbarColor: Colors.deepOrange,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio: CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                            ]
                        ).then((value) => {
                          value?.readAsBytes().then((bytes) => {
                            FirebaseStorage.instance.ref('${FirebaseAuth.instance.currentUser?.uid}.jpeg').putData(bytes).then((p0) => {
                              FirebaseFirestore.instance.collection('employees').doc(FirebaseAuth.instance.currentUser?.uid).update(
                                  {'timestamp': FieldValue.serverTimestamp()})
                            }),
                          })
                        });

                      })
                    }
                  });
                },
                  child: image == null ? Image.asset('assets/girl1.jpeg') : CircleAvatar(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(child: Image.memory(image!)),
                  ), radius: 100,)),
            ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('Users'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/users');
                },
              ),
            ),
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
