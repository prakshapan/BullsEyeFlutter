import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_page.dart';

void main() {
  runApp(BullsEyeFlutter());
}

class BullsEyeFlutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return MaterialApp(
        title: "Bulls Eye",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: GamePage(title: "Bulls Eye"));
  }
}
