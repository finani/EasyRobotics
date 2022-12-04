import 'package:flutter_test/flutter_test.dart';
import 'package:native_cpp/native_cpp.dart';
import 'package:native_cpp/native_cpp_platform_interface.dart';
import 'package:native_cpp/native_cpp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeCppPlatform
    with MockPlatformInterfaceMixin
    implements NativeCppPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeCppPlatform initialPlatform = NativeCppPlatform.instance;

  test('$MethodChannelNativeCpp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeCpp>());
  });

  test('getPlatformVersion', () async {
    NativeCpp nativeCppPlugin = NativeCpp();
    MockNativeCppPlatform fakePlatform = MockNativeCppPlatform();
    NativeCppPlatform.instance = fakePlatform;

    expect(await nativeCppPlugin.getPlatformVersion(), '42');
  });
}
