import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

Future testData() async {
  Firestore db = Firestore.instance;
  var data = await db.collection('event_details').getDocuments();
  var details = data.documents.toList();

  details.forEach((d) {
    print(d.documentID);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    testData();

    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(),
    );
  }
}
