import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:native_cpp/filter/first_order_filter.dart';
import 'package:easy_robotics/src/data/filter_chart_data.dart';

class AppMain extends StatefulWidget {
  const AppMain({
    super.key,
  });

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  final List<FilterChartData> _filterChartData = [];
  final _dataPointMaxNumber = 50;

  double _timeConstantSec = 0.2;
  late double _cutOffFreqHz;

  double _timeSec = 0.0;
  final _stepTimeMillisecond = 100;

  double _inputValue = 0.8;
  double _newInputValue = 0.8;

  @override
  void initState() {
    super.initState();

    firstOrderFilterResetFilter();
    firstOrderFilterSetParams(0.0, _timeConstantSec);
    _cutOffFreqHz = firstOrderFilterGetParams()[0];

    Timer.periodic(Duration(milliseconds: _stepTimeMillisecond), (timer) {
      setState(() {
        _getChartData(_inputValue);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _filterChartData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Order Filter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 10,
                ),
                Column(
                  children: [
                    const Text("Input vs Output"),
                    _buildLineChart(),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text("Input Value"),
                    _buildVerticalSlider(),
                  ],
                ),
                const Spacer(
                  flex: 10,
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 10,
                ),
                Column(
                  children: [
                    const Text("Cut off frequency [hz]"),
                    _buildCutOffFreqHzSlider(),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const Text("Time Constant [sec]"),
                    _buildTimeConstantSecSlider(),
                  ],
                ),
                const Spacer(
                  flex: 10,
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _getChartData(double newInput) {
    final output = firstOrderFilterCalc(newInput);
    _filterChartData.add(FilterChartData(_timeSec, newInput, output));
    if (_filterChartData.length > _dataPointMaxNumber) {
      _filterChartData.removeAt(0);
    }
    _timeSec += _stepTimeMillisecond / 1000.0;
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _buildLineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLine: const AxisLine(width: 0),
          minimum: 0,
          maximum: 1,
        ),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        series: _getLineSeries());
  }

  /// The method returns line series to chart.
  List<LineSeries<FilterChartData, num>> _getLineSeries() {
    return <LineSeries<FilterChartData, num>>[
      LineSeries<FilterChartData, num>(
        name: 'Input Value',
        dataSource: _filterChartData,
        xValueMapper: (FilterChartData sales, _) => sales.time,
        yValueMapper: (FilterChartData sales, _) => sales.input,
      ),
      LineSeries<FilterChartData, num>(
        name: 'Output Value',
        dataSource: _filterChartData,
        xValueMapper: (FilterChartData sales, _) => sales.time,
        yValueMapper: (FilterChartData sales, _) => sales.output,
      ),
    ];
  }

  Widget _buildVerticalSlider() {
    return SizedBox(
      width: 100,
      height: 300,
      child: SfSliderTheme(
        data: SfSliderThemeData(
          thumbRadius: 0,
          overlayRadius: 10,
          overlayColor: Colors.blue,
        ),
        child: SfSlider.vertical(
          min: 0.0,
          max: 1.0,
          interval: 0.2,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _newInputValue,
          onChanged: (dynamic newValue) {
            setState(() {
              _newInputValue = newValue;
            });
          },
          onChangeEnd: (dynamic newValue) {
            setState(() {
              _inputValue = _newInputValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildCutOffFreqHzSlider() {
    return SizedBox(
      width: 200,
      height: 100,
      child: SfSliderTheme(
        data: SfSliderThemeData(
          thumbRadius: 0,
          overlayRadius: 10,
          overlayColor: Colors.blue,
        ),
        child: SfSlider(
          min: 0.2,
          max: 0.8,
          interval: 0.2,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _cutOffFreqHz,
          onChanged: (dynamic newValue) {
            setState(() {
              _cutOffFreqHz = newValue;
              firstOrderFilterSetParams(_cutOffFreqHz, 0.0);
              _timeConstantSec = firstOrderFilterGetParams()[1];
            });
          },
        ),
      ),
    );
  }

  Widget _buildTimeConstantSecSlider() {
    return SizedBox(
      width: 200,
      height: 100,
      child: SfSliderTheme(
        data: SfSliderThemeData(
          thumbRadius: 0,
          overlayRadius: 10,
          overlayColor: Colors.blue,
        ),
        child: SfSlider(
          min: 0.2,
          max: 0.8,
          interval: 0.2,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _timeConstantSec,
          onChanged: (dynamic newValue) {
            setState(() {
              _timeConstantSec = newValue;
              firstOrderFilterSetParams(0.0, _timeConstantSec);
              _cutOffFreqHz = firstOrderFilterGetParams()[0];
            });
          },
        ),
      ),
    );
  }
}
