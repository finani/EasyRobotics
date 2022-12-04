import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_cpp_method_channel.dart';

abstract class NativeCppPlatform extends PlatformInterface {
  /// Constructs a NativeCppPlatform.
  NativeCppPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeCppPlatform _instance = MethodChannelNativeCpp();

  /// The default instance of [NativeCppPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeCpp].
  static NativeCppPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeCppPlatform] when
  /// they register themselves.
  static set instance(NativeCppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
