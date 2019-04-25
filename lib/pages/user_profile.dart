import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickup_app/services/globals.dart' as globals;

// ignore: camel_case_types
class Profile extends StatefulWidget {

  @override
  ProfileState createState() => ProfileState();
}

// ignore: camel_case_types
class ProfileState extends State<Profile> {
  File _image;
  Future getCamera() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (image != null) {
      _image = image;
      print(image.path);
      setState(() {
        _image = image;
      });
    }
  }

  Future getGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _image = image;
      print(image.path);
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
//              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 32.00,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Center(
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
                        border: new Border.all(color: Colors.white),
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                ExactAssetImage('assets/default_profile.jpg')),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Click icon to upload picture",
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: const Color(0xFFFFFFFF),
//                              fontWeight: FontWeight.bold,
                        fontFamily: "Roboto"),
                    textAlign: TextAlign.center,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          tooltip: 'Upload a picture by using camera',
                          color: Colors.white,
                          iconSize: 32.0,
                          icon: Icon(Icons.photo_camera),
                          onPressed: () {
                            getCamera();
                          }),
                      SizedBox(
                        width: 15.0,
                      ),
                      IconButton(
                          tooltip: 'Upload a picture from gallery',
                          color: Colors.white,
                          iconSize: 32.0,
                          icon: Icon(Icons.photo),
                          onPressed: () {
                            getGallery();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('users')
                          .where('userID', isEqualTo: globals.userId)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                         return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Name: " +
                                        snapshot.data.documents[0]
                                            ['first_name'] +
                                        " " +
                                        snapshot.data.documents[0]['last_name'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Phone Number: " +
                                        " " +
                                        snapshot.data.documents[0]['phone'],
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Email: " + globals.userEmail,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          return new Center(
                            child: new CircularProgressIndicator());
                        }
                      })
                ],
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.orangeAccent,
    );
  }
}
