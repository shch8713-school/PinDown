import 'package:flutter/material.dart';
import 'package:pickup_app/pages/Prelogin.dart';
import 'package:pickup_app/pages/map.dart';
import 'package:pickup_app/services/auth.dart';
import 'package:pickup_app/services/auth_provider.dart';

import 'form.dart';
import 'forgot_password.dart';
//import 'prelogin.dart';

import 'profile_page.dart';


class CorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context).auth;
    return StreamBuilder<String>(
        stream: auth.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return buildWaitingScreen();
          }
          final bool isLoggedin = snapshot.hasData;
            return isLoggedin ? MapPage() : Pre_();
        });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
