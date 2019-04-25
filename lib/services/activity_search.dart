import 'package:flutter/material.dart';
//import 'package:autocomplete_textfield/autocomplete_textfield.dart';
//import 'package:flutter_alert/
//import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:intl/intl.dart';
//import 'package:location/location.dart' as LocationManager;
//import 'package:google_maps_webservice/places.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'classes.dart';
import 'globals.dart' as globals;



// ignore: camel_case_types
class activity extends StatefulWidget{
  @override
  _activityState createState() => _activityState();
}
//onConfirm: (date) {
//                        print('confirm $date');
//                      },

// ignore: camel_case_types
class _activityState extends State<activity> {
  final _eventController = TextEditingController();
  bool _validate = false;
  final _date = DateTime.now();


  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
//          padding: EdgeInsets.symmetric(horizontal: 50.0),
          children: <Widget>[
//            Text('Error Showed if Field is Empty on Submit button Pressed'),
            ButtonBar(
              children: <Widget>[
                IconButton(
//                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  iconSize: 32.0,
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  tooltip: 'Back to searching activity',
                  onPressed: (){
                    Navigator.of(context).pushNamed('/event_create');
                  },
                ),
              SizedBox(width: 250.0,),
              IconButton(
//                alignment: Alignment.topRight,
                color: Colors.white,
                iconSize: 32.0,
                icon: Icon(
                  Icons.home,
                ),
                tooltip: 'Home(Map) Page',
                onPressed: (){
                  Navigator.of(context).pushNamed('/map');
                },
              ),
//                child: Align(
//                  alignment: Alignment.topRight,
//                  child: IconButton(
//                      color: Colors.white,
//                      iconSize: 32.0,
//                      icon: Icon(
//                        Icons.home,
//                      ),
//                      tooltip: 'Home(Map) Page',
//                      onPressed: (){
//                        Navigator.of(context).pushNamed('/map');
//                      }
//                  ),
//                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: new Text(
                "Your Event Name:",
                style: new TextStyle(
                    fontSize: 23.0,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"
                ),
                textAlign: TextAlign.left,
              ),
            ),
//            SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: new TextField(
                controller: _eventController,
                decoration: InputDecoration(
//                  labelText: 'Create your own event',
                  hintText: 'Enter your event name',
                  contentPadding: EdgeInsets.all(10),
                  errorText: _validate ? 'Event Name Can\'t Be Empty' : null,
                ),
                textCapitalization: TextCapitalization.words,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize:16.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
            ),
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: new Text(
                "Event Location:",
                style: new TextStyle(
                    fontSize: 23.0,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto"
                ),
                textAlign: TextAlign.left,
              ),
            ),
//            SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Theme(
                  data: Theme.of(context).copyWith(brightness: Brightness.light),
                  child: Align(
                    alignment: Alignment.center,
                    child: DropdownButton(
                      items: <String>['Ferrand', 'Norlin Quad', 'Kittridge Fields', 'Engineering Quad'].map((String value){
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      hint: new Text('Select your event location',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onChanged: (value){
                        globals.curfield = globals.fieldmap[value];

                        //value ? fields[1] = true : fields[1] = false;
//                      Navigator.of(context).pushNamed('/game_select');
                        print("$value");
                      },
                    ),
                  )
              ),
            ),
            SizedBox(height: 5.0,),
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 50.0),
//              child: new Text(
//                "Event Started Time:",
//                style: new TextStyle(
//                    fontSize: 23.0,
//                    color: const Color(0xFFFFFFFF),
//                    fontWeight: FontWeight.bold,
//                    fontFamily: "Roboto"
//                ),
//                textAlign: TextAlign.left,
//              ),
//            ),
//            SizedBox(height: 20.0,),
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: 30.0),
//              child: Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  InkWell(
//                    splashColor: Color(0xFF424242),//it revealed white only when it's in a pressed state
//                    onTap: (){
//                      DatePicker.showDateTimePicker(
//                          context,
//                          showTitleActions: true,
//                          onChanged: (date) {
//                            print('change $date');
//                          },
//                          onConfirm: (date) {
//                          print('confirm $date');
//                          },
//                          currentTime: DateTime.now()
//                      );
//                    },
//                    child: new Container(
//                      //width: 100.0,
//                      height: 35.0, //Button size
//                      decoration: new BoxDecoration(
//                        color: Colors.white,
//                        border: new Border.all(color: Colors.white),
//                        borderRadius: new BorderRadius.circular(35.0),
//                      ),
//                      child: new Center(
//                        child: new Text(
////                      errorText: _validate ? 'Event Name Can\'t Be Empty' : null
//                          'Click to choose time',
//                          style: new TextStyle(
//                            fontSize: 16.0,
//                            color: Colors.orangeAccent,
//                          ),
//                        ),
//
//                      ),
//                    ),
//                  ),
//                  SizedBox(height: 5,),
//                  Text("Your event will start on: $_date"),
//                ],
//              ),
//            ),
            //TODO Public/Private Event Using Radio
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                    child: const Text('Go!'),
                    textColor: Colors.orangeAccent,
                    color: Colors.white,
                    elevation: 4.0, //shadow of button
                    splashColor: Color(0xFF424242),
                    onPressed: (){
                      setState(() {
                        _eventController.text.isEmpty ? _validate = true : _validate = false;
                      });
                      if (_validate == true){
                        return _eventController.text.isEmpty;
                      } else {

                        createGame(_eventController.text, globals.curfield.name, globals.curfield.lat, globals.curfield.lon, 7);
                        Navigator.of(context).pushNamed('/map');
                      }
                    }
                )
              ),
            ),
          ],
        ),
      ),
    backgroundColor: Colors.orangeAccent,
    );
  }
}
