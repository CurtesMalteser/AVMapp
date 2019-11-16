import 'package:flutter/material.dart';
import 'package:avm/main.dart';
import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart' as prefix0;

class SecondRoute extends StatefulWidget {
  SecondRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class Data {
  final int minVal;
  final int maxVal;

  Data(this.minVal, this.maxVal);
}

class WaterModifiedData {
  final int consumed;
  final int average;

  WaterModifiedData({this.consumed, this.average});
}

class _SecondPageState extends State<SecondRoute> {
  final List<charts.Series> seriesList = List<charts.Series>();

  static List<charts.Color> createColorsData() {
    List<charts.Color> _createColorsData = List<charts.Color>();
    _createColorsData.add(charts.Color.fromHex(code: "#1E537B"));
    _createColorsData.add(charts.Color(a: 120, r: 30, g: 83, b: 123));

    return _createColorsData;
  }

  static int _consumedWater = 3800;

  static const averageConsumedWater = 4200;

  static WaterModifiedData calculatePercentageConsumedWater(int consumedWater) {
    int _averageConsumedWater = averageConsumedWater - consumedWater;

    return WaterModifiedData(
      consumed: consumedWater,
      average: _averageConsumedWater,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Data, int>> _createSampleData() {
    WaterModifiedData calculatedConsumedWater =
    calculatePercentageConsumedWater(_consumedWater);

    final data = [
      new Data(0, calculatedConsumedWater.consumed),
      new Data(1, calculatedConsumedWater.average),
    ];

    return [
      new charts.Series<Data, int>(
        id: 'Water',
        domainFn: (Data data, _) => data.maxVal,
        measureFn: (Data data, _) => data.maxVal,
        data: data,
        colorFn: (_, x) => createColorsData()[x],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route AVM"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Your daily water use",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto'
              ),
            ),
            SizedBox(
              width: 229.0,
              height: 229.0,
              child: charts.PieChart(
                _createSampleData(),
                animate: true,
                animationDuration: Duration(milliseconds: 500),
                selectionModels: [
                  new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener: null,
                  )
                ],
                defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 25,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                _showDialog(context);
              },
              child: Text('Pop Dialog!'),
            ),
            Text("Your daily consumption",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto'
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

// user defined function
void _showDialog(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: Text("Alert Dialog title"),
        content: Text("Alert Dialog body"),
        actions: <Widget>[
          FlatButton(
            child: Text("More Info"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text("Got it"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
