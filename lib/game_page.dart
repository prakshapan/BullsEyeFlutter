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
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
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
                    this._showAlert(context);
                  },
                ),
                Score(
                    round: _model.round,
                    totalScore: _model.totalScore,
                    onStartOver: _startNewGame)
              ]))),
    );
  }

  int _pointsForCurrentRound() {
    var maximumScore = 100;
    var difference = _amountOff();
    var bonus = 0;
    if (difference == 0) {
      bonus = 100;
    } else if (difference == 1) {
      bonus = 50;
    }
    return maximumScore - difference + bonus;
  }

  void _showAlert(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text("Awesome"),
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = _newTargetValue();
            _model.round++;
          });
        });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(_alertTitle()),
            content: Text(
                "The slider's value is ${_model.current}.\n You scored ${_pointsForCurrentRound()} this round."),
            actions: <Widget>[okButton],
            elevation: 5,
          );
        });
  }

  int _amountOff() => (_model.target - _model.current).abs();

  String _alertTitle() {
    var difference = _amountOff();
    String title;
    if (difference == 0) {
      title = "Perfect!";
    } else if (difference < 5) {
      title = "You almost had it!";
    } else if (difference <= 10) {
      title = "Not bad!";
    } else {
      title = "Are you even trying?";
    }

    return title;
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.totalScore = GameModel.SCORE_START;
      _model.round = GameModel.ROUND_START;
      _model.target = _newTargetValue();
      _model.current = GameModel.SLIDER_START;
    });
  }
}
