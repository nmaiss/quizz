import 'package:flutter/material.dart';
import 'package:quizz/players_quizz.dart';

class PreQuizzPage extends StatefulWidget {
  @override
  _PreQuizzPageState createState() => _PreQuizzPageState();
}

class _PreQuizzPageState extends State<PreQuizzPage> {

  final _formKey = GlobalKey<FormState>();
  final scoreController = TextEditingController();
  final numberPlayersController = TextEditingController();

  @override
  void dispose() {
    scoreController.dispose();
    numberPlayersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouveau quizz"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayersPage(numberPlayersController, scoreController)),
                );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
              child: TextFormField(
                controller: scoreController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: InputDecoration(
                  hintText: "Score pour gagner une manche",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une valeur';
                  }
                  else if (int.parse(value) < 3){
                    return 'Le score doit être supérieur ou égal à 3';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 40.0),
              child: TextFormField(
                controller: numberPlayersController,
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: InputDecoration(
                  hintText: "Nombre de joueurs",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une valeur';
                  }
                  else if (int.parse(value) < 3){
                    return 'Un minimum de 3 joueurs est requis';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

