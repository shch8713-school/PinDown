import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickup_app/services/auth_provider.dart';
import 'package:pickup_app/services/classes.dart';
import 'package:pickup_app/services/crud.dart';
import 'package:pickup_app/services/globals.dart' as globals;

// variable for input and to be added to database
String first;
String last;
String phone = "";
String email;
String password;
String confirmpass;
String confirmPsw;

// creates class object with necessary CRUD(Create Read Update Delete) methods
crudMethods crudObj = new crudMethods();

class RegForm extends StatefulWidget {
  // calls RegFormState to build content form form
  @override
  RegFormState createState() => RegFormState();
}

class RegFormState extends State<RegForm> {
  // this is not an actual flutter 'Form' widget so I created a boolean value to keep track of validity of form
  bool _validate = false;
  final formKey = new GlobalKey<FormState>();
  bool passwordVisible = false; //declare passwordVisible

  // ignore: must_call_super
  void initState() {
    passwordVisible = false;
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid');
      return true;
    } else {
      print('Form is invalid');
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      var auth = AuthProvider.of(context).auth;
      try {
        //addUser(globals.userId, first, last);
        //if the user exists and is logging in
        globals.userEmail = email;
        globals.userId =
            await auth.createUserWithEmailAndPassword(email, password);
        Map<String, dynamic> userData = {
          'first_name': first,
          'last_name': last,
          'phone': phone,
          'userID': globals.userId
        };
        crudObj.addUserData(userData);
        addUser(globals.userId, phone, first, last);
        readGames();
        getUser(globals.userId);
        Navigator.pushNamed(context, '/');
        //_showQuestionDialog();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      floatingActionButton: new FloatingActionButton(onPressed: null),
      appBar: new AppBar(
        backgroundColor: new Color(0xFFFFAB40),
        title: new Text('Register your Pick-Up account'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            new Text(
              "Register your Pick-Up account",
              style: new TextStyle(
                  fontSize: 23.0,
                  color: const Color(0xFFFFAB40),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto"),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Flexible(
                  // input for last name
                  child: new TextField(
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter',
                      labelText: "Last Name",
                      // check if empty
                      errorText: _validate ? 'Value can\'t be empty' : null,
                      contentPadding: EdgeInsets.all(10),
                    ),
                    // changes/store value if not empty
                    onChanged: (value) {
                      last = value;
                    },
                    textCapitalization: TextCapitalization.words,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                new Flexible(
                  // input for first name
                  child: new TextField(
                    decoration: InputDecoration(
                      //icon: const Icon(Icons.person),
                      hintText: 'Enter',
                      labelText: "First Name",
                      // check if empty
                      errorText: _validate ? 'Value can\'t be empty' : null,
                      contentPadding: EdgeInsets.all(10),
                      //hasFloatingPlaceholder: false,
                    ),
                    // change/store value if not empty
                    onChanged: (value) {
                      first = value;
                    },
                    textCapitalization: TextCapitalization.words,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 16.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),
                ),
              ],
            ),
            // input for phone number
            new TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: const Icon(Icons.phone),
                  hintText: 'Enter',
                  labelText: "Your phone number",
                  // check if empty
                  errorText: _validate ? 'Value can\'t be empty' : null,
                ),
                // change/store if not empty
                onChanged: (value) {
                  phone = value;
                },
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 16.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto")),
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    //controller: _usernameController,
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.email),
                      /*filled: true*/ labelText: 'Email',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Email can\'t be empty' : null,
                    onSaved: (value) => email = value,
                  ),
                  new TextFormField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        //                  hintText: 'Enter',
                        labelText: "Choose a password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible
                                  ? passwordVisible = false
                                  : passwordVisible = true;
                            });
                          },
                        ),
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => password = value,
                      obscureText: passwordVisible,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto")),
                  new TextFormField(
                      decoration: InputDecoration(
                        //icon: const Icon(Icons.lock_open),
                        icon: const Icon(Icons.lock),
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) =>
                          value == password ? 'Password doesn\'t match' : null,
                      onSaved: (value) => confirmpass = value,
                      obscureText: passwordVisible,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto")),
                ],
              ),
            ),

            ButtonBar(
              children: <Widget>[
                ButtonTheme(
                  minWidth: 4.00,
                  height: 35.00,
                  child: RaisedButton(
                    child: const Text(
                      'Back to Log In',
                      style: TextStyle(
                        fontSize:
                            16.00, //The max size can fit in the button bar
                      ),
                    ),
                    textColor: Colors.orangeAccent,
                    color: Colors.white,
                    elevation: 4.0, //shadow of button
                    splashColor: Color(
                        0xFF424242), //it revealed white only when it's in a pressed state
                    onPressed: () {
                      // TODO: Show the next page (101)
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: 4.00,
                  height: 35.00,
                  child: RaisedButton(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize:
                              16.00, //The max size can fit in the button bar
                        ),
                      ),
                    ),
                    textColor: Colors.orangeAccent,
                    color: Colors.white,
                    elevation: 4.0, //shadow of button
                    splashColor: Color(
                        0xFF424242), //it revealed white only when it's in a pressed state
                    onPressed: () {
                      // creates map similar to a dictionary with key and value key is 'String' type and value is 'dynamic' type
                      validateAndSubmit();
                      // calls crud object function to add data to cloud firestore
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
