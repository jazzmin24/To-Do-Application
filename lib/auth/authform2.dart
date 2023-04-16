import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/home.dart';

class AuthForm2 extends StatefulWidget {

  @override
  State<AuthForm2> createState() => _AuthForm2State();
}

class _AuthForm2State extends State<AuthForm2> {
 

 //---------------------------
  final _formkey = GlobalKey<FormState>();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
bool isLoginPage = false; //agr user phla se login h toh dont show his page

  //--------------------------


submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;

    UserCredential authresult;

    try {
      authresult = await auth.createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text);
            print(authresult);
        String uid = authresult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': usernamecontroller.text,
          'email': emailcontroller.text,
        });
       // Navigator.push(
       //   context,
        //  MaterialPageRoute(builder: (context) => const MyHomePage()),
       // );
      }
     catch (error) {
      print(error);
    }
  }


  //----------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //if u havent on thisn app before then this page will be shown
                           
          if(isLoginPage)
            TextFormField(
              controller: usernamecontroller,
              keyboardType: TextInputType.name,
              //key: ValueKey('username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Incorrect Username'; //agr empty usernsme ho toh dunno validate
                }
              },
              //  onSaved: (value) {
              //   _username = value!;
              // },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide()),
                labelText: 'Enter Username',
                //  labelStyle: GoogleFonts.roboto(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,
              //key: ValueKey('email'),
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Incorrect Email'; //agr empty email ho toh dunno validate
                }
              },
              //  onSaved: (value) {
              //    _email = value!;
              //  },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide()),
                labelText: 'Enter Email',
                //  labelStyle: GoogleFonts.roboto(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordcontroller,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              // key: ValueKey('password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Incorrect Password'; //agr empty email ho toh dunno validate
                }
              },
              // onSaved: (value) {
              //  _password = value!;
              //  },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide()),
                labelText: 'Enter Password',
                //  labelStyle: GoogleFonts.roboto(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //Container(
            MaterialButton(
              height: 40,
              minWidth: 200,
              color: Colors.purple,
              //     child: ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  print('validate');
                }
                 submitform(emailcontroller.text, passwordcontroller.text, usernamecontroller.text);
              },
              child:
                  //isLoginPage ? Text('Login') :
                  Text('SignUp'),
              //)
            ),

            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                   setState(() {
                   isLoginPage = !isLoginPage;
                  });
                  print("sreen is changed");
                },
                child:
                    isLoginPage
                    ? Text('Already a member?' , style: TextStyle(color: Colors.white),):
                    Text('Not a member?'  , style: TextStyle(color: Colors.white),) )
          ],
        ),
      ),
    );
  }
}
