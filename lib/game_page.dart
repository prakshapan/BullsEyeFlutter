import 'package:bullseye_flutter/control.dart';
import 'package:bullseye_flutter/gamemodel.dart';
import 'package:bullseye_flutter/prompt.dart';
import 'package:bullseye_flutter/score.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;
  GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Prompt(targetValue: _model.target),
          Control(
            model: _model,
          ),
          RaisedButton(
            child: Text("Hit me!", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              this._alertIsVisible = true;
              this._showAlert(context);
            },
          ),
          Score(
            round: _model.round,
            totalScore: _model.totalScore,
          )
        ])));
  }

  int _pointsForCurrentRound() {
    var maximumScore = 100;
    var difference = (_model.target - _model.current).abs();
    return maximumScore - difference;
  }

  void _showAlert(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text("Awesome"),
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
        });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hello there!"),
            content: Text("The slider's value is ${_model.current}.\n You scored ${_pointsForCurrentRound()} this round."),
            actions: <Widget>[okButton],
            elevation: 5,
          );
        });
  }
}
