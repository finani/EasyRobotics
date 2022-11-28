import 'native_add_platform_interface.dart';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:path/path.dart' as path;

final String libraryPath = path.join(
    Directory.current.parent.path, 'cppRobotics', 'build', 'libnative_add.so');

final DynamicLibrary cppRoboticsLib = DynamicLibrary.open(libraryPath);

// final DynamicLibrary nativeAddLib = Platform.isAndroid
//     ? DynamicLibrary.open('libnative_add.so')
//     : DynamicLibrary.process();

final int Function(int x, int y) nativeAdd = cppRoboticsLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('native_add')
    .asFunction();

class NativeAdd {
  Future<String?> getPlatformVersion() {
    return NativeAddPlatform.instance.getPlatformVersion();
  }
}
