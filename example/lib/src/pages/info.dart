import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const Text(
              "Easy Robotics",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text("github"),
            const Spacer(),
            QrImage(
              version: 6,
              // embeddedImage: , You can add your custom image to the center of your QR
              // semanticsLabel:'', You can add some info to display when your QR scanned
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              // padding: const EdgeInsets.all(5),
              size: 300,
              data: "https://github.com/finani/EasyRobotics",
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
