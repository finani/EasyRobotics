import 'native_cpp_platform_interface.dart';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
import 'package:path/path.dart' as path;

final String libraryPath = Platform.isLinux
    ? path.join(Directory.current.parent.path, 'cppRobotics', 'build',
        'libcpp_robotics.so')
    : Platform.isWindows
        ? path.join(Directory.current.parent.path, 'cppRobotics', 'build',
            'Debug', 'cpp_robotics.dll')
        : Platform.isAndroid
            ? 'libcpp_robotics.so'
            : "";

final DynamicLibrary cppRoboticsLib = (Platform.isIOS || Platform.isMacOS)
    ? DynamicLibrary.process()
    : DynamicLibrary.open(libraryPath);

final int Function(int x, int y) cppAdd = cppRoboticsLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>('cpp_add')
    .asFunction();

class NativeCpp {
  Future<String?> getPlatformVersion() {
    return NativeCppPlatform.instance.getPlatformVersion();
  }
}
