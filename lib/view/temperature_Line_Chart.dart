import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureLineChart extends StatefulWidget {

  final List date;
  final List maxTemp;
  final List minTemp;

  const TemperatureLineChart(this.date, this.maxTemp, this.minTemp);

  @override
  State<TemperatureLineChart> createState() => _TemperatureLineChartState(this.date, this.maxTemp, this.minTemp);
}

class _TemperatureLineChartState extends State<TemperatureLineChart> {

  final List date;
  final List maxTemp;
  final List minTemp;

  TooltipBehavior _tooltipBehavior;

  _TemperatureLineChartState(this.date, this.maxTemp, this.minTemp);

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      shared: true,
      activationMode: ActivationMode.singleTap,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.height / 1.05,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                isVisible: true,
                opposedPosition: false,
                isInversed: false,
              ),

                crosshairBehavior: CrosshairBehavior(
                  lineType: CrosshairLineType.horizontal,
                  enable: true,
                  shouldAlwaysShow: false,
                  activationMode: ActivationMode.singleTap,
                ),
                selectionType: SelectionType.series,
                isTransposed: false,
                selectionGesture: ActivationMode.singleTap,

                legend: Legend(
                  isVisible: false,
                  iconHeight: 10,
                  iconWidth: 10,
                  toggleSeriesVisibility: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.wrap,
                  alignment: ChartAlignment.center),
                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,

                series: <LineSeries<DateWeather, String>>[
                  LineSeries<DateWeather, String>(
                      dataSource:  <DateWeather>[
                        DateWeather(date[0], maxTemp[0]),
                        DateWeather(date[1], maxTemp[1]),
                        DateWeather(date[2], maxTemp[2]),
                        DateWeather(date[3], maxTemp[3]),
                        DateWeather(date[4], maxTemp[4]),
                      ],
                      xValueMapper: (DateWeather sales, _) => sales.date,
                      yValueMapper: (DateWeather sales, _) => sales.temp,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                    markerSettings: MarkerSettings(isVisible: true),
                  ),
                  LineSeries<DateWeather, String>(
                      dataSource:  <DateWeather>[
                        DateWeather(date[0], minTemp[0]),
                        DateWeather(date[1], minTemp[1]),
                        DateWeather(date[2], minTemp[2]),
                        DateWeather(date[3], minTemp[3]),
                        DateWeather(date[4], minTemp[4]),
                      ],
                      xValueMapper: (DateWeather sales, _) => sales.date,
                      yValueMapper: (DateWeather sales, _) => sales.temp,
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: false),

                      markerSettings: MarkerSettings(isVisible: true),
                  ),
                ]
            )
        )
    );
  }
}

class DateWeather {
  DateWeather(this.date, this.temp);
  final String date;
  final int temp;
}