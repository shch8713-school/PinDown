import 'package:flutter/material.dart';


class FrontPage extends StatefulWidget {
  //Login({this.onSignedIn});
  //final VoidCallback onSignedIn;

  @override
  FrontState createState() => FrontState();
}

class FrontState extends State<FrontPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 100.0),
          children: <Widget>[
            SizedBox(height: 60.0),
            Column(
              children: <Widget>[
                Image.asset('assets/logo.png', height: 110, width: 110,), //Width can be > 100, depends on the .png file of new design
                SizedBox(height: 10.0),
                Text(
                  "PinDown",
                  style: new TextStyle(
                      fontSize: 45.0,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto"
                  ),
                  textAlign: TextAlign.center,
                ),
//                Text
              ],
            ),
            SizedBox(height: 150.0),
            Container (
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  splashColor: Color(
                      0xFF424242), //it revealed white only when it's in a pressed state
                  onTap: () => Navigator
                      .pushNamed(context, '/home'), //Actions when tapping the button
                  child: new Container(
//                width: 50.0,
                    height: 35.0, //Button size
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.white),
                      borderRadius: new BorderRadius.circular(50.0),
                    ),
                    child: new Center(
                      child: new Text(
                        'Explore Campus Event!',
                        style:
                        new TextStyle(
                            fontSize: 16.0,
                            color: Colors.orangeAccent
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),

          ],
        ),
        )
      ),
      backgroundColor: Colors.orangeAccent,
    );
  }

      // [Password]
}