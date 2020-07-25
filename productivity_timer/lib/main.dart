import 'package:flutter/material.dart';
import 'package:work_timer/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
      ),
      body: Column(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Expanded(
              child: ProductivityButton(
                  color: Color(0xff009688),
                  text: "Work",
                  onPressed: emptyMethod),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Expanded(
              child: ProductivityButton(
                  color: Color(0xff607d8b),
                  text: "Short Break",
                  onPressed: emptyMethod),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Expanded(
              child: ProductivityButton(
                  color: Color(0xff455a64),
                  text: "Long Break",
                  onPressed: emptyMethod),
            ),
          ],
        ),
        Expanded(
          child: Text('Timer'),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Expanded(
              child: ProductivityButton(
                  color: Color(0xf212121),
                  text: "Stop",
                  onPressed: emptyMethod),
            ),
            Padding(
              padding: EdgeInsets.all(defaultPadding),
            ),
            Expanded(
              child: ProductivityButton(
                  color: Color(0xff009688),
                  text: "Restart",
                  onPressed: emptyMethod),
            ),
          ],
        ),
      ]),
    );
  }

  void emptyMethod() {}
}
