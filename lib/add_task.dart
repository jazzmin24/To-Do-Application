import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

//function to save data to firebae
  addTaskToFirebase() async {
    //ab jo user task likha ga vo sirf usko hi visible hoga uska liya h
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!; //do make chnges here
    String uid =
        user.uid; //getting user id of the user so that his tasks remains to him
    //var time = DateTime.now(); //time at tht moment when task is entered
    var time = DateFormat('dd-MM-yyyy').format(DateTime.now());
    print(time);

    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytask')
        .doc(time.toString())
        .collection('data')
        .add({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp':
          time //so tht tym is saved in tym stamp format and us data ko according to date and tym display kraya home page pr
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //we need two text feild for main topic and its description
        title: Text("New Task"),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: 'Enter Title', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Enter Description',
                      border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                  // width: double.infinity,
                  height: 20,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.purple.shade100;
                      return Theme.of(context).primaryColor;
                    })),
                    onPressed: () {
                      addTaskToFirebase();
                    },
                    child: Text('Add Task'),
                  ))
            ],
          )),
    );
  }
}


// ab jo bhi task hmna diya h vo home page pr visible hona chaiya for tht refer home page
