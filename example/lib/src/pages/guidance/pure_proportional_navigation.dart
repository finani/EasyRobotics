import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';

import 'package:easy_robotics/src/data/cartesian_2d_data.dart';
import 'package:native_cpp/guidance/pure_proportional_navigation.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PureProportionalNavigation extends StatefulWidget {
  const PureProportionalNavigation({
    super.key,
    required this.appBarColor,
  });

  final Color appBarColor;

  @override
  State<PureProportionalNavigation> createState() =>
      _PureProportionalNavigationState();
}

class _PureProportionalNavigationState
    extends State<PureProportionalNavigation> {
  late Timer timer_;
  var _isStop = false;

  final Pointer<Double> _pCurrentPosition =
      calloc.allocate(sizeOf<Double>() * 3);
  final Pointer<Double> _pTargetPosition =
      calloc.allocate(sizeOf<Double>() * 3);

  var currentPosition = Cartesian2dData(-20.0, -20.0);
  var targetPosition = Cartesian2dData(20.0, 20.0);

  var currentVelocity = Cartesian2dData(0.0, 10.0);
  final targetVelocity = Cartesian2dData(0.0, 0.0);

  final List<Cartesian2dData> _currentPositionData = [];
  final List<Cartesian2dData> _targetPositionData = [];
  final _dataPointMaxNumber = 100;

  double _n = 4.0;

  final _stepTimeMillisecond = 100;

  @override
  void initState() {
    super.initState();

    pureProportionalNavigationSetParams(_n);

    _pCurrentPosition[0] = currentPosition.x;
    _pCurrentPosition[1] = currentPosition.y;
    _pCurrentPosition[2] = 0.0;

    _pTargetPosition[0] = targetPosition.x;
    _pTargetPosition[1] = targetPosition.y;
    _pTargetPosition[2] = 0.0;
    pureProportionalNavigationSetPrevValues(
        _pCurrentPosition, _pTargetPosition);

    _currentPositionData
        .add(Cartesian2dData(currentPosition.x, currentPosition.y));
    _targetPositionData
        .add(Cartesian2dData(targetPosition.x, targetPosition.y));

    timer_ =
        Timer.periodic(Duration(milliseconds: _stepTimeMillisecond), (timer) {
      setState(() {
        if (_isStop) {
          return;
        }

        // update position
        currentPosition = Cartesian2dData(
            currentPosition.x +
                currentVelocity.x * _stepTimeMillisecond / 1000.0,
            currentPosition.y +
                currentVelocity.y * _stepTimeMillisecond / 1000.0);
        targetPosition = Cartesian2dData(
            targetPosition.x + targetVelocity.x * _stepTimeMillisecond / 1000.0,
            targetPosition.y +
                targetVelocity.y * _stepTimeMillisecond / 1000.0);

        // update position data for the chart
        _currentPositionData
            .add(Cartesian2dData(currentPosition.x, currentPosition.y));
        _targetPositionData
            .add(Cartesian2dData(targetPosition.x, targetPosition.y));

        // limit max data point
        if (_currentPositionData.length > _dataPointMaxNumber) {
          _currentPositionData.removeAt(0);
        }
        if (_targetPositionData.length > _dataPointMaxNumber) {
          _targetPositionData.removeAt(0);
        }

        // run algorithm
        _pCurrentPosition[0] = currentPosition.x;
        _pCurrentPosition[1] = currentPosition.y;
        _pCurrentPosition[2] = 0.0;

        _pTargetPosition[0] = targetPosition.x;
        _pTargetPosition[1] = targetPosition.y;
        _pTargetPosition[2] = 0.0;

        final accCmd = pureProportionalNavigationCalcAccCmd(
            _pCurrentPosition, _pTargetPosition);

        // update velocity
        final headingAngle = atan2(currentVelocity.y, currentVelocity.x);
        currentVelocity = Cartesian2dData(
            currentVelocity.x +
                accCmd *
                    cos(headingAngle - pi / 2.0) *
                    _stepTimeMillisecond /
                    1000.0,
            currentVelocity.y +
                accCmd *
                    sin(headingAngle - pi / 2.0) *
                    _stepTimeMillisecond /
                    1000.0);

        // check terminal condition
        final distance = sqrt((targetPosition.x - currentPosition.x) *
                (targetPosition.x - currentPosition.x) +
            (targetPosition.y - currentPosition.y) *
                (targetPosition.y - currentPosition.y));
        if (distance < 1.0) {
          _isStop = true;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer_.cancel();
    _targetPositionData.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Index 11: Pure Proportional Navigation"),
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
                  const Text("2D Map"),
                  _buildLineChart(),
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
                  const Text("N"),
                  _buildNSlider(),
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
    final chart2dNumericAxis = NumericAxis(
      majorTickLines: const MajorTickLines(color: Colors.transparent),
      axisLine: const AxisLine(width: 0),
      minimum: -30.0,
      maximum: 30.0,
      minorTicksPerInterval: 1,
    );

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: chart2dNumericAxis,
      primaryYAxis: chart2dNumericAxis,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
      series: _getLineSeries(),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<Cartesian2dData, num>> _getLineSeries() {
    return <LineSeries<Cartesian2dData, num>>[
      LineSeries<Cartesian2dData, num>(
        name: 'Current Position',
        dataSource: _currentPositionData,
        xValueMapper: (Cartesian2dData sales, _) => sales.x,
        yValueMapper: (Cartesian2dData sales, _) => sales.y,
      ),
      LineSeries<Cartesian2dData, num>(
        name: 'Target Position',
        dataSource: _targetPositionData,
        xValueMapper: (Cartesian2dData sales, _) => sales.x,
        yValueMapper: (Cartesian2dData sales, _) => sales.y,
      ),
    ];
  }

  Widget _buildNSlider() {
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
          min: 3.0,
          max: 5.0,
          interval: 0.5,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          value: _n,
          onChanged: (dynamic newValue) {
            setState(() {
              _n = newValue;
            });
          },
        ),
      ),
    );
  }
}
