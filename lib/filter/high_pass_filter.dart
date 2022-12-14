import '../native_cpp.dart';
import 'dart:ffi'; // For FFI

/// T curOutput = alpha_ * prevOutput_ + (1.0 - alpha_) * (curInput - prevInput_);
final double Function(double curInput) highPassFilterCalc = cppRoboticsLib
    .lookup<NativeFunction<Double Function(Double)>>('HighPassFilterCalc')
    .asFunction();

/// params[0] = config.cutOffFreqHz;
///
/// params[1] = config.timeConstantSec;
final Pointer<Double> Function() highPassFilterGetParams = cppRoboticsLib
    .lookup<NativeFunction<Pointer<Double> Function()>>(
        'HighPassFilterGetParams')
    .asFunction();

final void Function(double cutOffFreqHz, double timeConstantSec)
    highPassFilterSetParams = cppRoboticsLib
        .lookup<NativeFunction<Void Function(Double, Double)>>(
            'HighPassFilterSetParams')
        .asFunction();

final void Function() highPassFilterResetFilter = cppRoboticsLib
    .lookup<NativeFunction<Void Function()>>('HighPassFilterResetFilter')
    .asFunction();

final void Function() highPassFilterResetPrevValues = cppRoboticsLib
    .lookup<NativeFunction<Void Function()>>('HighPassFilterResetPrevValues')
    .asFunction();
