import 'package:flutter/material.dart';

// ignore: camel_case_types
class Forgot extends StatelessWidget {
  final _username = TextEditingController();
  final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: new Color(0xFFFFAB40),
        title: new Text("Generating you a new password..."),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            SizedBox (height: 40.00,),
            new Text(
              "Enter the following information",
              style: new TextStyle(fontSize: 23.0,
                  color: const Color(0xFFFFAB40),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox (height: 145.00,),
              new TextField(
                controller: _username,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your user name',
                  labelText: "Email of your Pick-UP account",
                  contentPadding: EdgeInsets.all(10),
                ),
                textCapitalization: TextCapitalization.words,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize:16.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
            SizedBox (height: 5.00,),
            new TextField(
                controller: _email,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  hintText: 'Enter your email',
                  labelText: "Email of this user name account ",
                  contentPadding: EdgeInsets.all(10),
            ),
                textCapitalization: TextCapitalization.words,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize:16.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto")
            ),
          ],
        ),
      ),
    );
  }
  void fabPressed() {}
}