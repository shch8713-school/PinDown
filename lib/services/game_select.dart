import 'dart:math';
import 'classes.dart';
import 'auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;
import 'package:flutter_alert/flutter_alert.dart';

class GameSelect extends StatefulWidget {
  @override
  GameSelectState createState() {
    return GameSelectState();
  }
}

class GameSelectState extends State<GameSelect> {
    List<DropdownMenuItem<Game>> displist = [];
    void loadDropGames(){
      int i = 0;
      while(i < globals.gameslist.length){
        var curGame = globals.gameslist[i];
        var gamename = curGame.gametype;
        //var players = curGame.players;
        var field = curGame.playspace.name;
        //var lat = curGame.playspace.lat;
        //var lon = curGame.playspace.lon;
        displist.add(new DropdownMenuItem(child: new Text('$gamename at $field'),
        value: curGame)
        );
      }
    }
    void _showQuestionDialog(Game chosen) {
      var gamename = chosen.gametype; 
      var gamecount = chosen.players;
      var gamespot = chosen.playspace.name;
    showAlert(
      context: context,
      title: 'Would you like to join $gamename ?',
      body: "Location: $gamespot Current Players: $gamecount",
      actions: [
        AlertAction(
          text: "Cancel",
          isDestructiveAction: true,
          onPressed: () {
            print("Do Nothing");
//            Navigator.of(context).pushNamed('/');
          },
        ),
        //last things to happen on login page
        AlertAction(
          text: "Join",
          isDestructiveAction: true,
          onPressed: () {
            updateGame(gamename, globals.userId);
            Navigator.of(context).pushNamed('/map'); //Direct to home page
            print('home page: map');
          },
        ),
      ],
    );
  }

    @override
    Widget build(BuildContext context){
      loadDropGames();
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('List of Games'),
          ),
          body: new Container(
            child: new Center(
              child: new DropdownButton(items: displist,
              onChanged: (value) => _showQuestionDialog(value),
            )
          )
          )
      )
      );
    }
}