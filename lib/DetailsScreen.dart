import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailsScreenSate createState() => _DetailsScreenSate();
}

class _DetailsScreenSate extends State<DetailsScreen> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
  final List<int> colorCodes = <int>[80, 75, 73, 65, 46, 0];

  bool isValueGreaterThanZero(double value) => value > 0;

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
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image(
                              image: NetworkImage(
                                  'https://pbs.twimg.com/profile_images/1107881890072145921/LfIoviqB_400x400.jpg'),
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Visibility(
                                  maintainState: true,
                                  maintainAnimation: true,
                                  maintainSize: true,
                                  visible: !isValueGreaterThanZero(
                                      colorCodes[index].toDouble()),
                                  child: Text(
                                      "There is no device connected yet.")),
                            ),
                            SizedBox(
                              height: 20,
                              width: 280,
                              child: Slider(
                                onChanged: (double newValue) {
                                  setState(() {});
                                },
                                min: 0,
                                max: 100,
                                value: colorCodes[index].toDouble(),
                                activeColor: sliderColorProcessor(
                                    colorCodes[index]),
                                inactiveColor: Color(0xff707070),
                                label: 'Set a value',
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child:
                            Text(
                                colorCodes[index].toString(),
                              style: TextStyle(
                                  color: sliderColorProcessor(colorCodes[index])
                              ),
                            ),
                        ),
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

// if color above threshold make red, bellow green and 0 grey
Color sliderColorProcessor(int value) {
  int threshold = 75;
  if (value >= threshold) {
    return Colors.red;
  } else if (value == 0)
    return Color(0xff707070);
  else {
    return Colors.green;
  }
}
