import '../native_cpp.dart';
import 'dart:ffi'; // For FFI

/// double accCmd = proportionalNavigationConfig_.n * losRate;
final double Function(
    Pointer<Double> pCurPos,
    Pointer<Double>
        pTargetPos) pureProportionalNavigationCalcAccCmd = cppRoboticsLib
    .lookup<NativeFunction<Double Function(Pointer<Double>, Pointer<Double>)>>(
        'PureProportionalNavigationCalcAccCmd')
    .asFunction();

/// double accCmd = proportionalNavigationConfig_.n * losRate;
final double Function(double losRate)
    pureProportionalNavigationCalcAccCmdFromLosRate = cppRoboticsLib
        .lookup<NativeFunction<Double Function(Double)>>(
            'PureProportionalNavigationCalcAccCmdFromLosRate')
        .asFunction();

/// params[0] = config.n;
final Pointer<Double> Function() pureProportionalNavigationGetParams =
    cppRoboticsLib
        .lookup<NativeFunction<Pointer<Double> Function()>>(
            'PureProportionalNavigationGetParams')
        .asFunction();

final void Function(double n) pureProportionalNavigationSetParams =
    cppRoboticsLib
        .lookup<NativeFunction<Void Function(Double)>>(
            'PureProportionalNavigationSetParams')
        .asFunction();

final double Function(
    Pointer<Double> pCurPos,
    Pointer<Double>
        pTargetPos) pureProportionalNavigationSetPrevValues = cppRoboticsLib
    .lookup<NativeFunction<Double Function(Pointer<Double>, Pointer<Double>)>>(
        'PureProportionalNavigationSetPrevValues')
    .asFunction();
