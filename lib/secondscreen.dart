import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as charts;
import 'DetailsScreen.dart';
import 'TimeSeriesChart.dart';

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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Text(
                    "Your daily water use",
                    style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                  ),
                ),
                SizedBox(
                  width: 229.0,
                  height: 229.0,
                  child: Stack(
                    children: <Widget>[
                      charts.PieChart(
                        _createSampleData(),
                        animate: false,
                        selectionModels: [
                          new charts.SelectionModelConfig(
                            type: charts.SelectionModelType.info,
                            changedListener: null,
                          )
                        ],
                        defaultRenderer: charts.ArcRendererConfig(
                          arcWidth: 16,
                        ),
                      ),
                      Center(
                        child: Text(
                          _consumedWater.toString() + "L",
                          style: TextStyle(
                              fontSize: 45,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                /*RaisedButton(
                  onPressed: () {
                    _showDialog(context);
                  },
                  child: Text('Pop Dialog!'),
                ),*/
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsScreen()),
                    );
                  },
                  child: Text('Details'),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Your daily consumption",
                          style: TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                          textAlign: TextAlign.right,
                          softWrap: false),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 229.0,
                    child: TimeSeriesBar.withSampleData(),
                  ),
                ],
              ),
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
