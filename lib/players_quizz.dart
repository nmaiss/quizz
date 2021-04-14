import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizz/quizz_page.dart';

import 'player.dart';

class PlayersPage extends StatefulWidget {
  TextEditingController numberPlayers, minScore;
  PlayersPage(this.numberPlayers, this.minScore);

  @override
  _PlayersPageState createState() => _PlayersPageState(this.numberPlayers, this.minScore);
}

class _PlayersPageState extends State<PlayersPage> {

  TextEditingController numberPlayers, minScore;
  _PlayersPageState(this.numberPlayers, this.minScore);

  List<TextEditingController> playersControllers = [];
  List<Player> players;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (int i = 0 ; i < int.parse(numberPlayers.text) ; i++) {
      var textEditingController = TextEditingController();
      playersControllers.add(textEditingController);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (TextEditingController textEditingController in playersControllers) {
      textEditingController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joueurs"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                List<Player> players = [];
                for (int i = 0 ; i < int.parse(numberPlayers.text) ; i++) {
                  players.add(Player(0, playersControllers[i].text));
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizzPage(players, int.parse(minScore.text))),
                );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: int.parse(numberPlayers.text),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0.0),
              child: TextFormField(
                controller: playersControllers[index],
                maxLength: 12,
                decoration: InputDecoration(
                  hintText: "Pseudo du joueur",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une valeur';
                  }
                  return null;
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

