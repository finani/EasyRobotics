import '../native_cpp.dart';
import 'dart:ffi'; // For FFI

/// T curOutput = alpha_ * curInput + (1.0 - alpha_) * prevOutput_;
final double Function(double curInput) lowPassFilterCalc = cppRoboticsLib
    .lookup<NativeFunction<Double Function(Double)>>('LowPassFilterCalc')
    .asFunction();

/// params[0] = config.cutOffFreqHz;
///
/// params[1] = config.timeConstantSec;
final Pointer<Double> Function() lowPassFilterGetParams = cppRoboticsLib
    .lookup<NativeFunction<Pointer<Double> Function()>>(
        'LowPassFilterGetParams')
    .asFunction();

final void Function(double cutOffFreqHz, double timeConstantSec)
    lowPassFilterSetParams = cppRoboticsLib
        .lookup<NativeFunction<Void Function(Double, Double)>>(
            'LowPassFilterSetParams')
        .asFunction();

final void Function() lowPassFilterResetFilter = cppRoboticsLib
    .lookup<NativeFunction<Void Function()>>('LowPassFilterResetFilter')
    .asFunction();

final void Function() lowPassFilterResetPrevValues = cppRoboticsLib
    .lookup<NativeFunction<Void Function()>>('LowPassFilterResetPrevValues')
    .asFunction();
