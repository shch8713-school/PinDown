import 'package:flutter/material.dart';
import 'package:pickup_app/pages/user_profile.dart';
import 'package:pickup_app/services/classes.dart';
import 'map.dart';
import 'login.dart';
import 'form.dart';
import 'forgot_password.dart';
import 'Prelogin.dart';
import 'package:pickup_app/services/event_create.dart';
import 'package:pickup_app/services/activity_search.dart';
//import 'profile_page.dart';
import 'package:pickup_app/services/auth_provider.dart';
import 'package:pickup_app/services/auth.dart';
import 'corepage.dart';
import 'package:pickup_app/services/globals.dart' as globals;


class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
      //readGames();
    //getUser(globals.userId);
    return AuthProvider(
        auth: Auth(),

        child: MaterialApp(
          title: 'Pick-Up',
          initialRoute: '/Prelogin',
          routes: {
            '/': (context) => CorePage(),
            '/login': (context) => Login(),
            '/home': (context) => MapPage(),
            '/form': (context) => RegForm(),
            '/forgot_password': (context) => Forgot(),
            '/Prelogin': (context) => Pre_(),
            '/activity_search': (context) => activity(),
            '/event_create': (context) => event(),
            '/profile': (context) => Profile(),
          //  '/profile_page': (context) => ProfileInfo(),

          },
        ));
  }
}
