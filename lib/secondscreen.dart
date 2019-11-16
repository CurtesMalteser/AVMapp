import 'package:flutter/material.dart';
import 'package:avm/main.dart';

class SecondRoute extends StatefulWidget {
  SecondRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1e537b),
      appBar: AppBar(
        title: Text("Second Route AVM"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text('Go back!'),
            ),
            RaisedButton(
              onPressed: () {
                _showDialog(context);
              },
              child: Text('Pop Dialog!'),
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
