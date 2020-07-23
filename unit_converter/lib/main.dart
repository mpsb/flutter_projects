import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final Map<String, int> _measuresMap = {
    'meters':0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
  
  double _numberFrom;
  String _startMeasure;
  String _convertedMeasure;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  @override
  void initState() {
    _numberFrom = 0;

    super.initState();
  }

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 20,
    color: Colors.grey[700],
  );

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measure Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              Text(
                'Value',
                style: labelStyle,
              ),
              Spacer(),
              TextField(
                style: inputStyle,
                decoration: InputDecoration(
                    hintText: "Please insert the measure to be converted"),
                onChanged: (text) {
                  var rv = double.tryParse(text);

                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
              ),
              Spacer(),
              Text(
                'From',
                style: labelStyle,
              ),
              DropdownButton(
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startMeasure = value;
                  });
                },
                value: _startMeasure,
              ),
              Spacer(),
              Text(
                'To',
                style: labelStyle,
              ),
              Spacer(),
              DropdownButton(
                items: _measures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure = value;
                  });
                },
                value: _convertedMeasure,
              ),
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                child: Text(
                  'Convert',
                  style: inputStyle,
                ),
                onPressed: () => true,
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                (_numberFrom == null) ? '' : _numberFrom.toString(),
                style: labelStyle,
              ),
              Spacer(
                flex: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
