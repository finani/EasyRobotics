import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.appBarColor,
  });

  final Color appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Index 2: Info"),
        backgroundColor: appBarColor,
      ),
    );
  }
}
