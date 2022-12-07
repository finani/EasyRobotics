import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:native_cpp/native_cpp.dart';
import 'package:native_cpp/cpp_add.dart';
import 'package:native_cpp/filter/first_order_filter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _nativeCppPlugin = NativeCpp();

  @override
  void initState() {
    super.initState();
    initPlatformState();

    const timeConstantSec = 0.1;
    firstOrderFilterSetParams(0.0, timeConstantSec);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _nativeCppPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Easy Robotics'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion'),
              Text('1 + 2 == ${cppAdd(1, 2)}'),
              Text('1 step = ${firstOrderFilterCalc(1.0)}'),
              Text('2 step = ${firstOrderFilterCalc(1.0)}'),
              Text('3 step = ${firstOrderFilterCalc(1.0)}'),
              Text('4 step = ${firstOrderFilterCalc(1.0)}'),
              Text('5 step = ${firstOrderFilterCalc(1.0)}'),
              Text('6 step = ${firstOrderFilterCalc(1.0)}'),
              Text('7 step = ${firstOrderFilterCalc(1.0)}'),
              Text('8 step = ${firstOrderFilterCalc(1.0)}'),
              Text('9 step = ${firstOrderFilterCalc(1.0)}'),
              Text('10 step = ${firstOrderFilterCalc(1.0)}'),
            ],
          ),
        ),
      ),
    );
  }
}
