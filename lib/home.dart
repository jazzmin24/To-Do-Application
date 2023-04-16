import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_application/add_task.dart';
import 'package:todo_application/description.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO APPLICATION"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,

//sign out buttout will be placed here
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context)
            .size
            .height, //to make it portable over mobile and laptops accordingly
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, DocumentSnapshot) {
            if (DocumentSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child:
                    CircularProgressIndicator(), //taaki task load hokr appear hoja
              );
            } else {
              print('we are processing');
              final document = DocumentSnapshot.data?.docs;

              return ListView.builder(
                  itemCount: document?.length,
                  itemBuilder: (context, index) {
                    var time =
                        (document![index]['timestamp'] as Timestamp).toDate();
                    return InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Description(
                      //                    title:document[index]['title'],
                      //                    description:document[index]['description'],
                      //               )));
                      // },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 90,
                        child: Row(
                          //wrappeded in row taaki usi line m dusbin bhi aayga na
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, //ab vo bin end m chaiya

                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // so tht mddle m ho mtlb asa phla bilkul container k starting m tha
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, //so tht text starts from the staring since phla vo middle m tha
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text(
                                        document[index][
                                            'title'], //title likho in those container which is to be displayed on home page
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                        DateFormat.yMd().add_jm().format(time)),
                                  )
                                ]),
                            Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await FirebaseFirestore
                                      .instance // jb delete pr click kra toh vo task delte ho jana chaiya from firebase also......so we can use time to delete this task
                                      .collection('tasks')
                                      .doc(uid)
                                      .collection('mytasks')
                                      .doc(document[index]['time'])
                                      .delete();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTask()));
          }),
    );
  }
}
