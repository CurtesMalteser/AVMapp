import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailsScreenSate createState() => _DetailsScreenSate();
}

class _DetailsScreenSate extends State<DetailsScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

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
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Overview of your water consumption"),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(
                    left: 16, top: 8, right: 16, bottom: 8),
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 60,
                    color: Colors.amber[colorCodes[index]],
                    //child: Center(child: Text('Entry ${entries[index]}')),
                    child: Row(
                      children: <Widget>[
                        Container(),
                        Container(),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
