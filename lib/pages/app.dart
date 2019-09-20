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
import 'new_front_page.dart';


class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
      //readGames();
    //getUser(globals.userId);
    var pinget = readGames(context);
    return AuthProvider(
        auth: Auth(),

        child: MaterialApp(
          title: 'PinDown',
          initialRoute: '/new_front_page',
          routes: {
            '/': (context) => CorePage(),
            '/login': (context) => Login(),
            '/new_front_page': (context) => FrontPage(),
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
