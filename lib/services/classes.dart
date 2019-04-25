import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  createField('Ferrand', 40.006009, -105.267693, 1),
  createField('Norlin Quad', 40.008729, -105.271468, 2),
  createField('Kittridge Fields', 40.002974, -105.259576, 3),
  createField('Engineering Quad', 40.006813, -105.264942, 4)
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

void setmarks() {
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
            InfoWindow(title: game.gametype, snippet: game.playspace.name),
        onTap: () {
          updateGame(game.gametype, globals.userId);
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
  dbref.child('games').child(game.gametype).set({
    //create game in database
    'location': game.playspace.name,
    'players': game.players,
    'playerlist': allusers,
  });
  dbref.child('games').child(title).child('field').set({
    //create field in game
    'name': location.name,
    'lat': location.lat,
    'lon': location.lon,
  });
}

//call this when a player adds themselves to a game
//just increments game's player count
void updateGame(String title, String uid) {
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
  readGames();
}

//call this to receive a list of game objects, one for each game in the db
//sets the global game list
void readGames() {
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
        setmarks();
      });
    });
  });
}
