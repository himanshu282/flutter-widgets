import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<_SalesData> data = [
    _SalesData('Mon', -1),
    _SalesData('Tue', 21),
    _SalesData('Wed', -1),
    _SalesData('Thu', 0),
    _SalesData('Fri', -1),
    _SalesData('Sat', 32),
    _SalesData('Sun', -1)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
            plotAreaBorderWidth: 0,
            trackballBehavior: TrackballBehavior(
              enable: true,
              markerSettings: const TrackballMarkerSettings(
                  markerVisibility: TrackballVisibilityMode.visible),
            ),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              minimum: 0,
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              axisLine: AxisLine(width: 0),
              majorGridLines: MajorGridLines(color: Colors.red),
              majorTickLines: MajorTickLines(width: 0),
              minorTickLines: MinorTickLines(width: 0),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: [
              LineSeries<_SalesData, String>(
                markerSettings: MarkerSettings(isVisible: true),
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Month',
                dataLabelSettings: const DataLabelSettings(isVisible: false),
              ),

              //   }
            ],
          ),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Half yearly sales analysis'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true))
              ]),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialize the spark charts widget
              child: SfSparkLineChart.custom(
                //Enable the trackball
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                //Enable marker
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
                //Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => data[index].year,
                yValueMapper: (int index) => data[index].sales,
                dataCount: 5,
              ),
            ),
          )
        ]));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
