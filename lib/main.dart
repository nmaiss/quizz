import 'package:flutter/material.dart';
import 'package:quizz/pre_quizz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _showRules() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Règles du jeu'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voici les règles du jeu.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Compris !'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _premiumMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fonctionnalité premium'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vous ne pouvez pas encore utiliser cette fonctionnalité premium.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok !'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 100.0),
                padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                child: Text(
                  "Règles",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                _showRules();
              },
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 150.0),
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Text(
                  "Normal",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreQuizzPage()),
                );
              },
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Text(
                  "Puriste",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                _premiumMessage();
              },
            ),
          ],
        ),
      )
    );
  }
}

