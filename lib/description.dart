import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  //const Description({super.key});

  late String title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Description')),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text('title'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text('description'),
            )
          ],
        ),
      ),
    );
  }
}
