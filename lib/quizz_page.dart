import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizz/main.dart';

import 'player.dart';
import 'question.dart';

class QuizzPage extends StatefulWidget {
  List<Player> players;
  int minScore;
  QuizzPage(this.players, this.minScore);

  @override
  _QuizzPageState createState() => _QuizzPageState(this.players, this.minScore);
}

class _QuizzPageState extends State<QuizzPage> {

  Future<void> _showLeaderboard() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Classement'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for (var i in players)
                  Text(i.name + " (" + i.score.toString() + " points)"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Player> players;
  int minScore;
  _QuizzPageState(this.players, this.minScore);

  List<Question> questions = [
    Question(false, "Question 1", "Réponse 1"),
    Question(false, "Question 2", "Réponse 2"),
    Question(false, "Question 3", "Réponse 3"),
    Question(false, "Question 4", "Réponse 4"),
    Question(false, "Question 5", "Réponse 5"),
    Question(false, "Question 6", "Réponse 6"),
    Question(false, "Question 7", "Réponse 7"),
    Question(false, "Question 8", "Réponse 8"),
    Question(false, "Question 9", "Réponse 9"),
    Question(false, "Question 10", "Réponse 10"),
    Question(false, "Question 11", "Réponse 11"),
    Question(false, "Question 12", "Réponse 12"),
    Question(false, "Question 13", "Réponse 13"),
    Question(false, "Question 14", "Réponse 14"),
    Question(false, "Question 15", "Réponse 15"),
    Question(false, "Question 16", "Réponse 16"),
  ];
  int currentRound = 1;
  String currentAnswer = "Réponse";
  int currQuest = 0;
  int currPlayer = 0;

  Future<void> _nextRound(String eliminated) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manche' + currentRound.toString()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(eliminated + " a été éliminé !")
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

  Future<void> _winner(String winner) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("La partie est terminée"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Le gagnant est " + winner + " !"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok !'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                  ModalRoute.withName('/')
                );
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static const duration = const Duration(seconds: 1);
  int secondPassed = 30;

  Timer timer;
  void handleTick() {
    setState(() {
      if (secondPassed > 0) {
        secondPassed = secondPassed - 1;
      }
    });
  }

  void _check(){
    int n = 0;
    int toEliminate;
    for (int i = 0 ; i < players.length ; i++){
      if (players[i].score >= minScore){
        n++;
      }
      else{
        toEliminate = i;
      }
    }
    if (n == players.length - 1){
      setState(() {
        currentRound++;
        if (players.length > 2) {
          _nextRound(players[toEliminate].name);
          players.removeAt(toEliminate);
        }
        else{
          players.removeAt(toEliminate);
          _winner(players[0].name);
        }
        for (int i = 0 ; i < players.length ; i++){
          players[i].score = 0;
        }
      });
    }
  }

  void initState() {
    currQuest = 0;
    currPlayer = 0;
    super.initState();
  }

  void _nextPlayer() {
    _check();
    setState(() {
      currQuest = (currQuest + 1) % questions.length;
      currPlayer = (currPlayer + 1) % players.length;
      currentAnswer = "Réponse";
      secondPassed = 30;
    });
  }

  void _rightAnswer() {
    players[currPlayer].score++;
    _nextPlayer();
  }

  @override
  Widget build(BuildContext context) {

    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }

    final globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text("Manche " + currentRound.toString()),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _showLeaderboard();
            },
            icon: Icon(Icons.leaderboard),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 120.0),
              child: Text(
                secondPassed.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red
                ),
              ),
            ),
            Container(
              child: Text(
                questions[currQuest].question,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              margin: EdgeInsets.only(top: 80.0),
              padding: EdgeInsets.fromLTRB(80, 50, 80, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (currentAnswer == "Réponse"){
                  setState(() {
                    currentAnswer = questions[currQuest].answer;
                  });
                }
                else{
                  setState(() {
                    currentAnswer = "Réponse";
                  });
                }
              },
              child: Container(
                child: Text(
                  currentAnswer,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                margin: EdgeInsets.only(top: 50.0),
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _nextPlayer(),
                    child: Container(
                      child: Icon(
                        Icons.thumb_down,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.fromLTRB(0, 50.0, 5, 0),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _rightAnswer(),
                    child: Container(
                      child: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.fromLTRB(5, 50.0, 0, 0),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

