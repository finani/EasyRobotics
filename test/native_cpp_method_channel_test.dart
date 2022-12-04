import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:native_cpp/native_cpp_method_channel.dart';

void main() {
  MethodChannelNativeCpp platform = MethodChannelNativeCpp();
  const MethodChannel channel = MethodChannel('native_cpp');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
