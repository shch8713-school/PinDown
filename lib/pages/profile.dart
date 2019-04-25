import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pickup_app/services/auth_provider.dart';
import 'package:pickup_app/services/crud.dart';
import 'package:pickup_app/services/globals.dart' as globals;
import 'package:flutter/material.dart';
//import 'package:flutter_alert/flutter_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'map.dart';

crudMethods crudObj = new crudMethods();

// ignore: camel_case_types
class ProfileO extends StatefulWidget {
  void lougOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      //onLoggedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  ProfileState createState() => ProfileState();
}

// ignore: camel_case_types
class ProfileState extends State<ProfileO> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        drawer: new Container(
          width: 250.0,
          color: Colors.orangeAccent,
          child: new ListView(
            children: <Widget>[
              new DrawerHeader(
                child: new Text(
                  'Hello!',
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFFFFAB40),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"),
                ),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                  // This align moves the children to the bottom
                  child: Align(
                      alignment: FractionalOffset.center,
                      child: Container(
                          child: Column(
                        children: <Widget>[
                          //Divider(),
                          ListTile(
                              leading: Container(
                            child: FlatButton(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Map",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
                              },
                            ),
                          )
                              //                                  Icon(Icons.settings),
                              //                                  title: Text('Settings')),
                              ),
                          ListTile(
                              leading: Container(
                            child: FlatButton(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Scheduled Activity",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                //                                        todo
                              },
                            ),
                          )),
                          ListTile(
                              leading: Container(
                            child: FlatButton(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Log Out",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  widget.lougOut(context);
                                  Navigator.pushNamed(context, '/');
                                }),
                          )
                              //                                  Icon(Icons.settings),
                              //                                  title: Text('Settings')),
                              ),
                        ],
                      ))))
            ],
          ),
        ),

        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      tooltip: 'Menu',
                      color: Colors.white,
                      iconSize: 32.00,
                      icon: Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(50.0),
                  child: Center(
                    child: new Container(
                      width: 150.0,
                      height: 150.0,
                      child: Center(
                        child: _image == null
                            ? Text('No image selected.')
                            : Image.file(_image),
                      ),
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: ExactAssetImage(
                                  'assets/default_profile.jpg'))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ButtonTheme(
                      minWidth: 16.00,
                      height: 35.00,
                      child: RaisedButton(
                          child: const Text('Upload Profile Picture'),
                          textColor: Colors.orangeAccent,
                          color: Colors.white,
                          elevation: 4.0, //shadow of button
                          splashColor: Color(0xFF424242),
                          onPressed: () {
                            getImage();
                          }),
                    ),
                  ),
                ),
                ListTile(
                  leading: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('users')
                        .where('userID', isEqualTo: globals.userId)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: ListView(
                            children: <Widget>[
                              Text(
                                "First Name: " + snapshot.data.documents[0]['first_name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Last Name: " + snapshot.data.documents[0]['last_name'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Phone: " + snapshot.data.documents[0]['phone'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return new Center(
                            child: new CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
//      body: Center(
//        child: new Container(
//          padding: EdgeInsets.all(25.0),
//          width: 150.0,
//          height: 150.0,
////          child: Center(
////            child: _image == null
////                ? Text('No image selected.')
////                : Image.file(_image),
////          ),
////          child: Image.asset('assets/default_profile.jpg', fit: BoxFit.contain, alignment: FractionalOffset.topCenter,),
//          decoration: new BoxDecoration(
//            shape: BoxShape.circle,
//              image: new DecorationImage(
//                fit: BoxFit.fill,
//                alignment: FractionalOffset.topCenter,
//                image: ExactAssetImage('assets/default_profile.jpg')
//              ),
////            color: Colors.white,
//          ),
//        ),
//        child: _image == null
//            ? Text('No image selected.')
//            : Image.file(_image),
//      ),

//      floatingActionButton: FloatingActionButton(
//        onPressed: getImage,
//        tooltip: 'Pick Image',
//        child: Icon(Icons.add_a_photo),
//      ),
        backgroundColor: Colors.orangeAccent,
      ),
    );
  }
}
