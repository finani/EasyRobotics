import '../native_cpp.dart';
import 'dart:ffi'; // For FFI

final double Function(double curInput) firstOrderFilterCalc = cppRoboticsLib
    .lookup<NativeFunction<Double Function(Double)>>('FirstOrderFilterCalc')
    .asFunction();

final void Function(double cutOffFreqHz, double timeConstantSec)
    firstOrderFilterSetParams = cppRoboticsLib
        .lookup<
            NativeFunction<
                Void Function(Double cutOffFreqHz,
                    Double timeConstantSec)>>('FirstOrderFilterSetParams')
        .asFunction();

final void Function() firstOrderFilterResetFilter = cppRoboticsLib
    .lookup<NativeFunction<Void Function()>>('FirstOrderFilterResetFilter')
    .asFunction();

final void Function() firstOrderFilterResetPrevValues = cppRoboticsLib
    .lookup<NativeFunction<Void Function()>>('FirstOrderFilterResetPrevValues')
    .asFunction();
