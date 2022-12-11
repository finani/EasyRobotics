import 'package:flutter/material.dart';

class Maps extends StatelessWidget {
  const Maps({
    super.key,
    required this.appBarColor,
  });

  final Color appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Index 1: Maps"),
        backgroundColor: appBarColor,
      ),
    );
  }
}
