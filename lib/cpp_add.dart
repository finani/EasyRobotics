import 'native_cpp.dart';
import 'dart:ffi'; // For FFI

final int Function(int x, int y) cppAdd = cppRoboticsLib
    .lookup<NativeFunction<Int Function(Int, Int)>>('cpp_add')
    .asFunction();
