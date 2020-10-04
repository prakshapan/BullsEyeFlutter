import 'package:flutter/foundation.dart';
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
  bool _alertIsVisible = false;

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
          RaisedButton(
            child: Text("Hit me!", style: TextStyle(color: Colors.blue)),
            onPressed: () {
              this._alertIsVisible = true;
              this._showAlert(context);
            },
          ),
          FlatButton(
            child: Text("Knock Knock!", style: TextStyle(color: Colors.red)),
            onPressed: () {
              this._alertIsVisible = true;
              this._showKnockKnockAlert(context);
            },
          )
        ])));
  }

  void _showKnockKnockAlert(BuildContext context) {
    Widget dismissButton = FlatButton(
      child: Text("Dismiss"),
      onPressed: () {
        this._alertIsVisible = false;
        Navigator.of(context).pop();
      },
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [dismissButton],
            title: Text("Who's there?"),
            content: Text("Some random joke!"),
          );
        });
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
            content: Text("This is my first popup"),
            actions: <Widget>[okButton],
            elevation: 5,
          );
        });
  }
}
