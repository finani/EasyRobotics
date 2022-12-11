import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/common_types.dart';
import 'package:easy_robotics/src/data/filter_chart_data.dart';
import 'package:native_cpp/filter/first_order_filter.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.appBarColor,
    required this.onPush,
  });

  final Color appBarColor;
  final OnPush onPush;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<FilterChartData> _filterChartData = [];
  final _dataPointMaxNumber = 50;

  double _timeConstantSec = 0.2;
  late double _cutOffFreqHz;

  late double _timeSec;
  final _stepTimeMillisecond = 100;

  double _inputValue = 0.8;
  double _newInputValue = 0.8;

  @override
  void initState() {
    super.initState();

    _timeSec = 0.0;
    firstOrderFilterResetFilter();

    firstOrderFilterSetParams(0.0, _timeConstantSec);
    _cutOffFreqHz = firstOrderFilterGetParams()[0];

    Timer.periodic(Duration(milliseconds: _stepTimeMillisecond), (timer) {
      setState(() {
        final input = _inputValue;
        final output = firstOrderFilterCalc(input);

        _filterChartData.add(FilterChartData(_timeSec, input, output));
        if (_filterChartData.length > _dataPointMaxNumber) {
          _filterChartData.removeAt(0);
        }

        _timeSec += _stepTimeMillisecond / 1000.0;
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
        title: const Text("Index 0: Home"),
        // title: const Text('First Order Filter'),
        backgroundColor: widget.appBarColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 10),
                Column(children: [
                  const Text("Input vs Output"),
                  _buildLineChart(),
                ]),
                const Spacer(),
                Column(children: [
                  const Text("Input Value"),
                  _buildInputValueVerticalSlider(),
                ]),
                const Spacer(flex: 10),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 10),
                Column(children: [
                  const Text("Cut off frequency [hz]"),
                  _buildCutOffFreqHzSlider(),
                ]),
                const Spacer(),
                Column(children: [
                  const Text("Time Constant [sec]"),
                  _buildTimeConstantSecSlider(),
                ]),
                const Spacer(flex: 10),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _buildLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
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
      series: _getLineSeries(),
    );
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

  Widget _buildInputValueVerticalSlider() {
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