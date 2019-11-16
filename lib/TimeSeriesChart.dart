/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TimeSeriesBar extends StatelessWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;

  TimeSeriesBar(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory TimeSeriesBar.withSampleData() {
    return new TimeSeriesBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2019, 10, 27), 5),
      new TimeSeriesSales(new DateTime(2019, 10, 28), 5),
      new TimeSeriesSales(new DateTime(2019, 10, 29), 25),
      new TimeSeriesSales(new DateTime(2019, 10, 30), 100),
      new TimeSeriesSales(new DateTime(2019, 10, 31), 75),
      new TimeSeriesSales(new DateTime(2019, 11, 1), 88),
      new TimeSeriesSales(new DateTime(2019, 11, 2), 65),
      new TimeSeriesSales(new DateTime(2019, 11, 3), 91),
      new TimeSeriesSales(new DateTime(2019, 11, 4), 100),
      new TimeSeriesSales(new DateTime(2019, 11, 5), 111),
      new TimeSeriesSales(new DateTime(2019, 11, 6), 90),
      new TimeSeriesSales(new DateTime(2019, 11, 7), 50),
      new TimeSeriesSales(new DateTime(2019, 11, 8), 40),
      new TimeSeriesSales(new DateTime(2019, 11, 9), 30),
      new TimeSeriesSales(new DateTime(2019, 11, 10), 40),
      new TimeSeriesSales(new DateTime(2019, 11, 11), 50),
      new TimeSeriesSales(new DateTime(2019, 11, 12), 30),
      new TimeSeriesSales(new DateTime(2019, 11, 13), 35),
      new TimeSeriesSales(new DateTime(2019, 11, 14), 40),
      new TimeSeriesSales(new DateTime(2019, 11, 15), 32),
      new TimeSeriesSales(new DateTime(2019, 11, 16), 31),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}