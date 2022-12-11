import 'dart:async';
import 'package:flutter/material.dart';

import 'package:easy_robotics/src/app_logo.dart';
import 'package:easy_robotics/src/app_main.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Timer _timer;
  bool _isLoadingTimeOut = false;

  _AppState() {
    _timer = Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _isLoadingTimeOut = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingTimeOut) {
      return const AppMain();
    }

    return const AppLogo();
  }
}
