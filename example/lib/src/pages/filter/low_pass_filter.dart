import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/filter_chart_data.dart';
import 'package:native_cpp/filter/low_pass_filter.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class LowPassFilter extends StatefulWidget {
  const LowPassFilter({
    super.key,
    required this.appBarColor,
  });

  final Color appBarColor;

  @override
  State<LowPassFilter> createState() => _LowPassFilterState();
}

class _LowPassFilterState extends State<LowPassFilter> {
  late Timer timer_;

  final List<FilterChartData> _filterChartData = [];
  final _dataPointMaxNumber = 50;

  double _timeConstantSec = 0.02;
  late double _cutOffFreqHz;

  late double _timeSec;
  final _stepTimeMillisecond = 100;

  double _dcInput = 0.0;
  double _newDcInput = 0.0;

  double _amplitude = 0.0;
  double _newAmplitude = 0.0;

  double _frequency = 0.2;
  double _newFrequency = 0.2;

  @override
  void initState() {
    super.initState();

    _timeSec = 0.0;
    lowPassFilterResetFilter();

    lowPassFilterSetParams(0.0, _timeConstantSec);
    _cutOffFreqHz = lowPassFilterGetParams()[0];

    timer_ =
        Timer.periodic(Duration(milliseconds: _stepTimeMillisecond), (timer) {
      setState(() {
        final input =
            _dcInput + _amplitude * sin(2 * pi * _frequency * _timeSec);
        final output = lowPassFilterCalc(input);

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
    timer_.cancel();
    _filterChartData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Index 01: Low Pass Filter"),
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
                  const Text("DC Input"),
                  _buildDcInputVerticalSlider(),
                ]),
                const Spacer(),
                Column(children: [
                  const Text("Sine Amp"),
                  _buildSineAmplitudeVerticalSlider(),
                ]),
                Column(children: [
                  const Text("Sine Freq [hz]"),
                  _buildSineFrequencyVerticalSlider(),
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
        minimum: -2,
        maximum: 2,
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

  Widget _buildDcInputVerticalSlider() {
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
          min: -1.0,
          max: 1.0,
          interval: 0.2,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _newDcInput,
          onChanged: (dynamic newValue) {
            setState(() {
              _newDcInput = newValue;
            });
          },
          onChangeEnd: (dynamic newValue) {
            setState(() {
              _dcInput = _newDcInput;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSineAmplitudeVerticalSlider() {
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
          value: _newAmplitude,
          onChanged: (dynamic newValue) {
            setState(() {
              _newAmplitude = newValue;
            });
          },
          onChangeEnd: (dynamic newValue) {
            setState(() {
              _amplitude = _newAmplitude;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSineFrequencyVerticalSlider() {
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
          min: 0.2,
          max: 1.0,
          interval: 0.2,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _newFrequency,
          onChanged: (dynamic newValue) {
            setState(() {
              _newFrequency = newValue;
            });
          },
          onChangeEnd: (dynamic newValue) {
            setState(() {
              _frequency = _newFrequency;
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
          min: 0.0,
          max: 8.0,
          interval: 2.0,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _cutOffFreqHz,
          onChanged: (dynamic newValue) {
            setState(() {
              if (newValue < 0.08) newValue = 0.08;
              _cutOffFreqHz = newValue;
              lowPassFilterSetParams(_cutOffFreqHz, 0.0);
              _timeConstantSec = lowPassFilterGetParams()[1];
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
          min: 0.0,
          max: 2.0,
          interval: 0.5,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _timeConstantSec,
          onChanged: (dynamic newValue) {
            setState(() {
              if (newValue < 0.02) newValue = 0.02;
              _timeConstantSec = newValue;
              lowPassFilterSetParams(0.0, _timeConstantSec);
              _cutOffFreqHz = lowPassFilterGetParams()[0];
            });
          },
        ),
      ),
    );
  }
}
