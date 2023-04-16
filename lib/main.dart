import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/auth/authscreen.dart';
import 'package:todo_application/home.dart';

import 'auth/authform2.dart';

Future<void> main()
//async
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
     apiKey: "AIzaSyDD-uprhsXmW6vd07AIyOSrRqM7j-uR46U",
  authDomain: "todo-firebase-38ae9.firebaseapp.com",
  projectId: "todo-firebase-38ae9",
  storageBucket: "todo-firebase-38ae9.appspot.com",
  messagingSenderId: "363059414530",
  appId: "1:363059414530:web:4e2abe3e3dc18cbc04491b",
  measurementId: "G-RSXCTFWB2T"
  ));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.purple),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, usersnapshot) {
            print(usersnapshot);
            if (usersnapshot.hasData) {
              return MyHomePage();
            } else {
              return AuthForm2();
            }
          },
        ));
  }
}
