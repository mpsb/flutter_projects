import 'package:flutter/material.dart';
import 'package:work_timer/timermodel.dart';
import 'package:work_timer/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';

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
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            final CountDownTimer timer = CountDownTimer();

            timer.startWork();

            return Column(children: [
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
              StreamBuilder(
                  initialData: "00:00",
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == "00:00")
                        ? TimerModel("00:00", 1)
                        : snapshot.data;
                    return Expanded(
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 10,
                        percent: timer.percent,
                        center: Text(timer.time,
                            style: Theme.of(context).textTheme.headline4),
                        progressColor: Color(0xff009688),
                      ),
                    );
                  }),
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
            ]);
          },
        ));
  }

  void emptyMethod() {}
}
