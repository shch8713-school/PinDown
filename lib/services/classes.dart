import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'globals.dart' as globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pickup_app/pages/map.dart';
import 'dart:math';
//add dependency "firebase_database: ^2.0.3" to pubspec.yaml

//import 'package:flutter/material.dart';

//defien classes to organize game and field data
class Game {
  String gametype;
  Field playspace;
  int players;
  String allplayers;

  Game();

  Game.full(String title, Field fieldspace) {
    this.gametype = title;
    this.playspace = fieldspace;
    this.players = 1;
    this.allplayers = '';
  }
  Game.exists(String title, int mems, String playlist, Field fieldspace) {
    this.gametype = title;
    this.playspace = fieldspace;
    this.players = mems;
    this.allplayers = playlist;
  }
}

class Field {
  String name;
  double lat;
  double lon;
  int pos;

  Field(String fname, double up, double down, int id) {
    this.name = fname;
    this.lat = up;
    this.lon = down;
    this.pos = id;
  }
}

class User {
  String uid;
  String fname;
  String lname;
  String username;

  User(String uid, String fname, String lname, String username) {
    this.uid = uid;
    this.fname = fname;
    this.lname = lname;
    this.username = username;
  }
}
//premade field list
//globals.fields = [createField('Ferrand', 40.006009, -105.267693, 1), createField('Norlin Quad', 40.008729, -105.271468, 2), createField('Kittridge Fields', 40.002974, -105.259576, 3), createField('Engineering Quad', 40.006813, -105.264942, 4)];
//globals.fields = fields;

var fields = [
  createField('Ferrand', 40.005995, -105.269660, 1),
  createField('Norlin Quad', 40.008309, -105.273120, 2),
  createField('Kittridge Fields', 40.002470, -105.259921, 3),
  createField('Engineering Quad', 40.006627, -105.265233, 4),
  createField('Business Field', 40.005221, -105.262992, 5),
  createField('Sewall Field', 40.009507, -105.271183, 6),
  createField('Physics Quad', 40.007350, -105.268030, 7)
];

void mapfields() {
  print('mapping the fields');
  Map<String, Field> fieldmap = new Map.fromIterable(
    fields,
    key: (field) => field.name,
    value: (field) => field,
  );
  globals.fieldmap = fieldmap;
}

//connect to firebase
final dbref = FirebaseDatabase.instance.reference();

void setmarks(BuildContext context) {
  print('Creating Pins');
  print(globals.gameslist.length);
  int i = 0;
  Set<Marker> mapmarks = new Set();
  while (i < globals.gameslist.length) {
    print('in the loop');
    Game game = globals.gameslist[i];
    print(game.gametype);
    i = i + 1;
    print(i);
    Marker thismark = Marker(
        markerId: MarkerId(game.gametype),
        position: LatLng(
          game.playspace.lat,
          game.playspace.lon,
        ),
        infoWindow:
            InfoWindow(title: game.gametype, snippet: 'Players:${game.players}'),
        onTap: () {
          showAlert
          (
            context: context,
            title: 'Join ${game.gametype}?',
            body: "Location: ${game.playspace.name} \n Players: ${game.players}",
            actions: [
              AlertAction(
                text: "Cancel",
                isDestructiveAction: true,
                onPressed: () {
                  print("Do Nothing");
                //Navigator.of(context).pushNamed('/home');
                },
              ),
              AlertAction(
                text: "Join",
                isDestructiveAction: true,
                onPressed: () {
                  //Navigator.pushNamed(context, '/home'); //Direct to home page
                  updateGame(game.gametype, globals.userId, context);
                },
              ),
            ],
          );
          
              
        });
    print('adding the mark');
    mapmarks.add(thismark);
  }
  print('taking marks global');
  globals.mapmarks = mapmarks;
}

//function to create a field
//takes name, both coorinates, id = pos in fields array
Field createField(String fname, double lat, double lon, int id) {
  var field = new Field(fname, lat, lon, id);
  return field;
}

//add a user to the database
void addUser(String uid, String uname, String fname, String lname) {
  var user = new User(uid, fname, lname, uname);
  dbref.child('users').child(uid).set({
    // db/users/[uid]
    'fname': user.fname,
    'lname': user.lname,
    'uname': user.username,
  });
}

//get the current user from the database
//sets the global user
void getUser(String uid) {
  print('begin getuser');
  globals.userId = uid;
  dbref.child('users').child(uid).once().then((DataSnapshot usersnap) {
    //Map<dynamic, dynamic> uvals = usersnap.value;
    //print(uvals.toString());
    var myUser = new User(uid, usersnap.value['fname'], usersnap.value['lname'],
        usersnap.value['uname']);
    globals.myUser = myUser;
  });
}

//function to create game, push to server
//takes name of game and a field object //creates game with name, field, 1 player
void createGame(
    String title, String fieldname, double fieldlat, double fieldlon, int id) {
  var location = new Field(fieldname, fieldlat, fieldlon, id);
  var game = new Game.full(title, location);
  String allusers = globals.userId;
  //creating random value
  final _random = new Random();
  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  double next() => _random.nextDouble();
  double latadd = next()/3000;
  double lonadd = next()/3000;
  //end random value deal

  dbref.child('games').child(game.gametype).set({
    //create game in database
    'location': game.playspace.name,
    'players': game.players,
    'playerlist': allusers,
  });
  dbref.child('games').child(title).child('field').set({
    //create field in game
    'name': location.name,
    'lat': location.lat + latadd,
    'lon': location.lon + lonadd,
  });
}

//call this when a player adds themselves to a game
//just increments game's player count
void updateGame(String title, String uid, context) {
  Map gamemap = globals.gamemap;
  int players = gamemap[title].players;
  players = players + 1;
  String uplayerlist = gamemap[title].allplayers;
  String uidloc = globals.userId;
  //String comma = ',';
  uplayerlist = '$uplayerlist,$uidloc';
  dbref.child('games').child(title).update({
    'players': players,
    'playerlist': uplayerlist,
  });
  readGames(context);
}

//call this to receive a list of game objects, one for each game in the db
//sets the global game list
void readGames(BuildContext context) {
  mapfields();
  print('reading games');
  //var tgame = new Game.exists('localgame', 3, 'yeet and yeetet', fields[0]);
  List<Game> games = [];
  dbref.child('games').once().then((DataSnapshot snapshot) {
    Map<dynamic, dynamic> values = snapshot.value;
    print(values.toString());
    values.forEach((key, values) {
      dbref
          .child('games')
          .child(key)
          .child('field')
          .once()
          .then((DataSnapshot fsnap) {
        games.add(new Game.exists(
            key,
            values['players'],
            values['playerlist'],
            new Field(fsnap.value['name'], fsnap.value['lat'],
                fsnap.value['lon'], fsnap.value['id'])));
        globals.gameslist = games;
        Map<String, Game> gamemap = new Map.fromIterable(
          games,
          key: (game) => game.gametype,
          value: (game) => game,
        );
        globals.gamemap = gamemap;
        setmarks(context);
      });
    });
  });
}

 /* void makeDialogue(BuildContext context, Game game)
  {
    showAlert
    (
      context: context,
      title: 'Allow "Pick-UP" to access your location?',
      body: "Your location will not be displayed or shared with others.",
      actions: [
        AlertAction(
          text: "Don't Allow",
          isDestructiveAction: true,
          onPressed: () {
            print("Do Nothing");
          //Navigator.of(context).pushNamed('/home');
          },
        ),
        AlertAction(
          text: "Allow",
          isDestructiveAction: true,
          onPressed: () {
            //Navigator.pushNamed(context, '/home'); //Direct to home page
            print('home page: map');
          },
        ),
      ],
    );
  }*/

