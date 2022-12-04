import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_cpp_platform_interface.dart';

/// An implementation of [NativeCppPlatform] that uses method channels.
class MethodChannelNativeCpp extends NativeCppPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_add');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
