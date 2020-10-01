import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Text(
            "Welcome to the app!",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          FlatButton(
            child: Text("Hit me!", style: TextStyle(color: Colors.blue)),
            onPressed: () {},
          )
        ])));
  }
}
