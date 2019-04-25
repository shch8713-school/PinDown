import 'dart:math';
import 'package:pickup_app/services/auth_provider.dart';
import 'package:pickup_app/services/classes.dart';
import 'form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickup_app/services/globals.dart' as globals;

class ProfileInfo extends StatefulWidget {
  @override
  ProfileInfoState createState() {
    return ProfileInfoState();
  }
}

class ProfileInfoState extends State<ProfileInfo> {
  String id;
  final db = Firestore.instance;

  String name;
  String firstName;
  String lastName;
  String userName;
  String phone;

  String usid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((userId) {
      usid = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P!ckUp Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[

          RaisedButton(
            //onPressed: createData,
            child: Text('Test: addUser', style: TextStyle(color: Colors.white)),
            color: Colors.green,
             onPressed: () {
              addUser('fakeuid', 'testuname', 'testfname', 'testlname');
            },
          ),

          RaisedButton(
                //onPressed: createData,
                child: Text('Test: getUser', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: (){
                  String uid = globals.userId;
                  getUser(uid);
                  print(globals.myUser.fname);
                  print(globals.myUser.lname);
                  print(globals.myUser.username);
                  print(globals.userId);
                },            
              ),

          RaisedButton(
            //onPressed: createData,
            child: Text('Test: createGame', style: TextStyle(color: Colors.white)),
            color: Colors.green,
            onPressed: () {
              //readGames();
              createGame('TestGame','mynewfield', 9.5, 7.3, 2);
              //print('created game done');
              //readGames();
              //print(globals.gamemap['TestGame'].playspace.name);
            },
          ),
          
          RaisedButton(
            //onPressed: createData,
            child: Text('Test: updateGame', style: TextStyle(color: Colors.white)),
            color: Colors.green,
            onPressed: () {
              updateGame('TestGame', globals.userId);
              readGames();
            },
          ),

          RaisedButton(
                //onPressed: createData,
                child: Text('Test: readGames', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: (){
                  readGames();
                },
              ),
          RaisedButton(
                //onPressed: createData,
                child: Text('Test: BigTest', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                onPressed: (){
                  addUser('uidbigtest', 'unamebigtest', 'fnamebigtest', 'lnamebigtest');
                  getUser('uidbigtest');
                  print(globals.userId);
                  print(globals.myUser.fname);
                  print(globals.myUser.lname);
                  print(globals.myUser.username);
                  createGame('GameAdded', 'FieldAdded', 3.3, 3.3, 4);
                  readGames();
                  print('firstread');
                  int i = 0;
                  while(i < 3){
                     print(globals.gameslist[i].gametype);
                     print(globals.gameslist[i].allplayers);
                     print(globals.gameslist[i].players);
                     print(globals.gameslist[i].playspace.name);
                     print(globals.gameslist[i].playspace.lat);
                     print(globals.gameslist[i].playspace.lon);
                     i++;
                  } 
                  updateGame('GameAdded', globals.userId);
                  print('post-update');
                  int j = 0;
                  while(j < 3){
                     print(globals.gameslist[j].gametype);
                     print(globals.gameslist[j].allplayers);
                     print(globals.gameslist[j].players);
                     print(globals.gameslist[j].playspace.name);
                     print(globals.gameslist[j].playspace.lat);
                     print(globals.gameslist[j].playspace.lon);
                     j++;
                  } 
                
                },
              ),
        ],
      ),
    );
  }
}
