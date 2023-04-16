import 'package:flutter/material.dart';
//import 'package:todo_application/auth/authform.dart';
import 'package:todo_application/auth/authform2.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
        backgroundColor: Colors.purple,
      ),
      body: AuthForm2(),
    );
  }
}
