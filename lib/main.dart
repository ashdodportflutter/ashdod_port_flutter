import 'package:ashdod_port_flutter/screens/create_acount.dart';
import 'package:ashdod_port_flutter/screens/getting_started.dart';
import 'package:ashdod_port_flutter/screens/home_page.dart';
import 'package:ashdod_port_flutter/screens/login_page.dart';
import 'package:ashdod_port_flutter/screens/edit_user_page.dart';
import 'package:ashdod_port_flutter/screens/presnce_list_page.dart';
import 'package:ashdod_port_flutter/screens/users_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder> {
        '/getReady': (BuildContext context) => const GetReadyPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/create_account': (BuildContext context) => const CreateAccount(),
        '/edit_user_page': (BuildContext context) => const EditUserPage(),
        '/home_page': (BuildContext contex) => HomePage(),
        '/list': (BuildContext contex) => PresenceListPage(),
        '/users': (BuildContext contex) => UsersPage()

      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GetReadyPage()
    );
  }
}

