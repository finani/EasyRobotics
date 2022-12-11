import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ffi';

import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter/services.dart';
import 'package:native_cpp/native_cpp.dart';
import 'package:native_cpp/cpp_add.dart';
import 'package:native_cpp/filter/first_order_filter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _nativeCppPlugin = NativeCpp();

  Timer? _timer;
  final List<_ChartData> _chartData = [];
  double _step = 0.0;
  double _input = 1.0;
  double _newInput = 1.0;
  final _dataPointMaxNumber = 20;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    firstOrderFilterResetFilter();
    const timeConstantSec = 0.1;
    firstOrderFilterSetParams(0.0, timeConstantSec);

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _getChartData(_input);
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _nativeCppPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Easy Robotics'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text('Running on: $_platformVersion'),
              Text('1 + 2 == ${cppAdd(1, 2)}'),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("First Order Filter"),
                      _buildAnimationLineChart(),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Input Value"),
                      _buildVerticalSlider(),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text("Cut off frequency [hz]"),
                      _buildCutOffFreqHzSlider(),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Time Constant [sec]"),
                      _buildTimeConstantSecSlider(),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  ///Get the cartesian chart with line series
  SfCartesianChart _buildAnimationLineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis:
            NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
        legend: Legend(isVisible: true),
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLine: const AxisLine(width: 0),
          minimum: 0,
          maximum: 1,
        ),
        series: _getDefaultLineSeries());
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          dataSource: _chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          dataSource: _chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _chartData.clear();
  }

  void _getChartData(double newInput) {
    final output = firstOrderFilterCalc(newInput);
    _chartData.add(_ChartData(_step, output, newInput));
    if (_chartData.length > _dataPointMaxNumber) {
      _chartData.removeAt(0);
    }
    _step += 1;
    _timer?.cancel();
  }

  Widget _buildVerticalSlider() {
    return SizedBox(
      width: 100,
      height: 100,
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
          value: _newInput,
          onChanged: (dynamic newValue) {
            setState(() {
              _newInput = newValue;
            });
          },
          onChangeEnd: (dynamic newValue) {
            setState(() {
              _input = _newInput;
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

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}
