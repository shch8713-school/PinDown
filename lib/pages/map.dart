import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

//import 'dart:ui' as ui;
import 'package:pickup_app/services/globals.dart' as globals;
import 'package:pickup_app/services/auth_provider.dart';


class MapPage extends StatefulWidget {
  //MapPage({this.onLoggedOut});
  //final VoidCallback onLoggedOut;

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
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GoogleMapController mapController;

  // void _onMapCreated(GoogleMapController controller){
  //   mapController = controller;
  // }
  Completer<GoogleMapController> _controller = Completer();

//  static final CameraPosition _kCuBoulder = CameraPosition(
//    target: LatLng(40.008131, -105.263782),
//    zoom: 14.4746,
//  );

//  static final CameraPosition _hill = CameraPosition(
//    target: LatLng(40.009832, -105.276522),
//    zoom: 14.4746,
//  );

//  static final CameraPosition _kFolsomField = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(40.008131, -105.263782),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

//  static final CameraPosition _kFarrandField = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(39.978069, -105.261045),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

//  static final CameraPosition _kKittredgeField = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(40.0031513, -105.2624734),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

//  static final CameraPosition _kWilliamsVillageField = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(40.0000562, -105.2364027),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);
//
//  static final CameraPosition _kLowerRecField = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(40.013933, -105.263218),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);
//
//  static final CameraPosition _kSportsDomeField = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(40.013933, -105.263218),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//  Marker _pin = Marker(
//      markerId: MarkerId('Ferrand'), position: LatLng(40.006009, -105.267693)
//      //position: LatLng(40.009448,-105.266813)
//
//      );
//  Marker _pin1 = Marker(
//      markerId: MarkerId('Norlin Quads'),
//      position: LatLng(40.008729, -105.271468)
//      //position: LatLng(40.009448,-105.266813)
//      );
//
//  Marker _pin2 = Marker(
//      markerId: MarkerId('Kittridge Fields'),
//      position: LatLng(40.002974, -105.259576)
//      //position: LatLng(40.009448,-105.266813)
//      );
//
//  Marker _pin3 = Marker(
//      markerId: MarkerId('Engineering Quads'),
//      position: LatLng(40.006813, -105.264942)
//      //position: LatLng(40.009448,-105.266813)
//      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Scaffold(
      //   key: _scaffoldKey,
      //    drawer:  Container(
      //     width: 250.0,
      //     color: Colors.orangeAccent,
      //     child: new ListView(
      //       children: <Widget>[
      //         new DrawerHeader(
      //           child: new Text('Hello!',
      //             style: new TextStyle(
      //               fontSize: 16.0,
      //               color: const Color(0xFFFFAB40),
      //               fontWeight: FontWeight.bold,
      //               fontFamily: "Roboto"
      //             ),
      //           ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: new Container(
            width: 250.0,
            color: Colors.orangeAccent,
            child: new ListView(children: <Widget>[
              new Container(
                child: new DrawerHeader(
//                    child: new CircleAvatar(
//                      maxRadius: 10.0,
//                      backgroundColor: Colors.orangeAccent,
//                      padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection('users')
                              .where('userID', isEqualTo: globals.userId)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Hello ' + snapshot.data.documents[0]['first_name'] + '!',
                                  style: new TextStyle(
                                      fontSize: 16.0,
                                      color: const Color(0xFFFFAB40),
//                                fontWeight: FontWeight.bold,
                                      fontFamily: "Roboto"),
                                ),
                              );
                            } else {
                              return Align(
                                child: new CircularProgressIndicator(),
                              );
                            }
                          }),
//                          new Text(
//                            "Hello User!",
//                            style: new TextStyle(
//                                fontSize: 16.0,
//                                color: const Color(0xFFFFAB40),
////                                fontWeight: FontWeight.bold,
//                                fontFamily: "Roboto"
//                            ),
//                            textAlign: TextAlign.left,
//                          ),
                      Center(
                        child: new Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  ExactAssetImage('assets/default_profile.jpg'),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "View Profile",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                    ],
                  ),
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
                          child: Column(children: <Widget>[
                        //Divider(),
                        ListTile(
                            leading: Container(
                          child: FlatButton(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/profile');
                            },
                          ),
                        )
//                                  Icon(Icons.settings),
//                                  title: Text('Settings')),
                            ),
//                        ListTile(
//                            leading: Container(
//                          child: FlatButton(
//                            child: Align(
//                              alignment: Alignment.centerLeft,
//                              child: Text(
//                                "Log Out",
//                                style: TextStyle(
//                                  fontSize: 16.0,
//                                  color: Colors.white,
//                                ),
//                              ),
//                            ),
//                            onPressed: () {
//                              globals.userId = null;
//                              globals.userEmail = null;
//                              widget.lougOut(context);
//                              globals.myUser = null;
//                              globals.userId = null;
//                              globals.userEmail = null;
//                              globals.gameslist = null;
//                              globals.gamemap = null;
//                              globals.fields = null;
//                              globals.fieldmap = null;
//                              Navigator.pushNamed(context, '/');
//                              //var globals;
//                            },
//                          ),
//                        )
////                                  Icon(Icons.settings),
////                                   title: Text('Settings')),
//                            ),
                      ])))), //endof inner container
            ])),
        body: Stack(
          children: <Widget>[
            Container(
//              height: MediaQuery.of(context).size.height,
//              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                myLocationEnabled: true,
                  compassEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(40.006941, -105.271505),
                    zoom: 15.0,
                  ),

                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;
                  },

                  markers: globals.mapmarks
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: RaisedButton(
//                  tooltip: 'Menu',
                child: const Text('Pin filter for events'),
                  textColor: Colors.white,
                  color: Colors.orangeAccent,
//                  iconSize: 32.00,
                  elevation: 4.0, //shadow of button
                  splashColor: Color(0xFF424242),
//                  icon: Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState.openDrawer(),
                ),
              ),
            ),
//          SizedBox(height: 10.0,),
//            Padding(
//              padding: const EdgeInsets.all(25.0),
//              child: Align(
//                alignment: Alignment.topCenter,
//                child: ButtonTheme(
//                  minWidth: 8.00,
//                  height: 35.00,
//                  child: RaisedButton(
//                      child: const Text('Create an Activity'),
//                      textColor: Colors.white,
//                      color: Colors.orangeAccent,
//                      elevation: 4.0, //shadow of button
//                      splashColor: Color(0xFF424242),
//                      onPressed: () {
//                        Navigator.of(context).pushNamed('/activity_search');
//                      }),
//                ),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  /* Future<void> _goToTheField() async {
     final GoogleMapController controller = await _controller.future;
     controller.animateCamera(CameraUpdate.newCameraPosition(_kFolsomField));
   }*/

// Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                 tooltip: 'Menu',
//                 color: Colors.orangeAccent,
//                   iconSize: 32.00,
//                   icon: Icon(
//                     Icons.menu
//                   ),
//                 onPressed: () => _scaffoldKey.currentState.openDrawer(),
//               ),
//             ),
//           ),
// //          SizedBox(height: 10.0,),
//           Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: ButtonTheme(
//                 minWidth: 8.00,
//                 height: 35.00,
//                 child: RaisedButton(
//                   child: const Text('Choose/Create an Activity'),
//                   textColor: Colors.white,
//                   color: Colors.orangeAccent,
//                   elevation: 4.0, //shadow of button
//                   splashColor: Color(0xFF424242),
//                   onPressed: (){
//                     Navigator.of(context).pushNamed('/event_create');
//                   }
//                 ),
//               ),
//             ),
//           )
//             ],
//           ),
//         ),

//       );
//   }
// }

  //               }
  //             ),
  //           ),
  //         ),
  //       )
  //       ),

  // ),
  //     ]
  //     )

  //       ))}

//   GoogleMapController mapController;

//   // void _onMapCreated(GoogleMapController controller){
//   //   mapController = controller;
//   // }
//    Completer<GoogleMapController> _controller = Completer();

//  static final CameraPosition _kCuBoulder = CameraPosition(
//     target: LatLng(40.008131, -105.263782),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kFolsomField = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(40.008131, -105.263782),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//       static final CameraPosition _kFarrandField = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(39.978069, -105.261045),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//       static final CameraPosition _kKittredgeField = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(40.0031513, -105.2624734),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//        static final CameraPosition _kWilliamsVillageField = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(40.0000562, -105.2364027),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//        static final CameraPosition _kLowerRecField = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(40.013933, -105.263218),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//        static final CameraPosition _kSportsDomeField = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(40.013933, -105.263218),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//  Future<void> _goToTheField() async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(_kFolsomField));
//  }
}
