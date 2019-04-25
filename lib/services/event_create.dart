import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
//import 'package:flutter_alert/flutter_alert.dart';


// ignore: camel_case_types
class event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
         children: <Widget>[
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                color: Colors.white,
                iconSize: 32.0,
                icon: Icon(
                  Icons.arrow_back,
                ),
                tooltip: 'Home(Map) Page',
                onPressed: (){
                Navigator.of(context).pushNamed('/home');
                }
              ),
            ),
            ),
            SizedBox(height: 25.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: new SimpleAutoCompleteTextField(
                key: key,
                suggestions: [
                  "Flag Football",
                  "Dancing",
                  "Yoga",
                  "Football",
                  "Swimming",
                  "Water Polo",
                  "Basketball",
                  "Baseball",
                  "Softball",
                  "Badminton",
                  "Tennis",
                  "Ping Pong",
                  "Frisbee",
                  "Soccer",
                  "Skating",
                  "Gaming",
                  "Bowling",
                  "Pool",
                  "Hiking",
                ],
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.orangeAccent,
                    hintText: 'Create/join activity'
                ),
              ),
            ),
            SizedBox(height: 400.0,),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ButtonTheme(
                  minWidth: 8.00,
                  height: 35.00,
                  child: RaisedButton(
                      child: const Text('Create your activity'),
                      textColor: Colors.orangeAccent,
                      color: Colors.white,
                      elevation: 4.0, //shadow of button
                      splashColor: Color(0xFF424242),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/activity_search');
                      }
                  ),
                ),
              ),
            )
         ],

////          padding: EdgeInsets.symmetric(horizontal: 50.0),
////          children: <Widget>[
////            ButtonBar(
////              children: <Widget>[
////                IconButton(
////                  alignment: Alignment.topLeft,
////                  color: Colors.white,
////                  iconSize: 32.0,
////                  icon: Icon(
////                    Icons.arrow_back,
////                  ),
////                  tooltip: 'Back',
////                  onPressed: (){
////                    Navigator.of(context).pushNamed('/map');
////                  },
////                ),
//              padding: const EdgeInsets.all(25.0),
//                child: Align(
//                  alignment: Alignment.topLeft,
//                  child: IconButton(
//                      color: Colors.white,
//                      iconSize: 32.0,
//                      icon: Icon(
//                          Icons.arrow_back,
//                      ),
//                      tooltip: 'Back to Searching Activity',
//                      onPressed: (){
//                        Navigator.of(context).pushNamed('/map');
//                      }
//                  ),
////
//////              padding: const EdgeInsets.all(25.0),
////                SizedBox(width: 150.0,),
////                ButtonTheme(
//////                  padding: EdgeInsets.symmetric(horizontal: 50.0),
////                  minWidth: 8.00,
////                  height: 35.00,
////                  child: RaisedButton(
////                    textColor: Colors.orangeAccent,
////                    color: Colors.white,
////                    elevation: 4.0, //shadow of button
////                    splashColor: Color(0xFF424242),
////                    child: Align(
////                      alignment: Alignment.topRight,
////                      child: const Text('Create an Activity'),
////                    ),
////                      onPressed: (){
////                        Navigator.of(context).pushNamed('/activity_search');
////                      },
////                  ),
////                ),
//////                child: Align(
//////                  alignment: Alignment.topRight,
//////                  child: IconButton(
//////                      color: Colors.white,
//////                      iconSize: 32.0,
//////                      icon: Icon(
//////                        Icons.home,
//////                      ),
//////                      tooltip: 'Home(Map) Page',
//////                      onPressed: (){
//////                        Navigator.of(context).pushNamed('/map');
//////                      }
//////                  ),
//////                ),
////              ],
////            ),
//            SizedBox(height: 25.0,),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 40.0),
//              child: new SimpleAutoCompleteTextField(
//                key: key,
//                suggestions: [
//                  "Flag Football",
//                  "Dancing",
//                  "Yoga",
//                  "Football",
//                  "Swimming",
//                  "Water Polo",
//                  "Basketball",
//                  "Baseball",
//                  "Softball",
//                  "Badminton",
//                  "Tennis",
//                  "Ping Pong",
//                  "Frisbee",
//                  "Scooer",
//                  "Skating",
//                  "Gaming",
//                  "Bowling",
//                  "Pool",
//                  "Hiking",
//                ],
//                decoration: InputDecoration(
//                    filled: true,
//                    fillColor: Colors.orangeAccent,
//                    hintText: 'Search an activity to join/schedule'
//                ),
//              ),
//            ),
////            SizedBox(height: 395,),
////            SimpleAutoCompleteTextField(
////              key: key,
////              suggestions: [
////                "Flag Football",
////                "Dancing",
////                "Yoga",
////                "Football",
////                "Swimming",
////                "Water Polo",
////                "Basketball",
////                "Baseball",
////                "Softball",
////                "Badminton",
////                "Tennis",
////                "Ping Pong",
////                "Frisbee",
////                "Scooer",
////                "Skating",
////                "Gaming",
////                "Bowling",
////                "Pool",
////                "Hiking",
////              ],
////              decoration: InputDecoration(
////                filled: true,
////                fillColor: Colors.orangeAccent,
////                hintText: 'Enter an activity you want to do'
////              ),
////            ),
////            new Container(
////              child: ListView(
////                children: <Widget>[
//          ],
        ),
      ),
      //],
      //),
      //),
      backgroundColor: Colors.orangeAccent,
    );
  }
}