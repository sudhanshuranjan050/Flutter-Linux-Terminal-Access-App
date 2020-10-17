import 'package:Linux_App/views/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController passInputController;
  @override
  initState() {
    emailInputController = new TextEditingController();
    passInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.lobster(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(width: 5, color: Colors.white),
                  ),
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 400,
                        height: 200,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                              width: 300,
                              child: Image.asset("assets/images/linux.png"),
                            ),
                            Text(
                              "Linux Terminal",
                              style: GoogleFonts.sansita(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Card(
                  elevation: 20,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.black, width: 3)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          hintText: "Enter your Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailInputController,
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.white,
                          ),
                          labelStyle:
                              TextStyle(fontSize: 15.0, color: Colors.black),
                          hintText: "Enter your Password ",
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: passInputController,
                        validator: pwdValidator,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 250,
                  child: RaisedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    elevation: 20,
                    color: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.black, width: 3)),
                    onPressed: () {
                      if (_loginFormKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                              email: emailInputController.text,
                              password: passInputController.text,
                            )
                            .then((currentUser) => Firestore.instance
                                .collection("user")
                                .document(currentUser.user.uid)
                                .get()
                                .then(
                                  (DocumentSnapshot result) =>
                                      Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  ),
                                )
                                .catchError((err) => print(err)))
                            .catchError((err) => print(err));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Don't have an account yet?"),
                FlatButton(
                  child: Text("Register here!"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/registration");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
