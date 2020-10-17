import 'package:Linux_App/views/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController emailInputController;
  TextEditingController passInputController;

  @override
  initState() {
    emailInputController = new TextEditingController();
    passInputController = new TextEditingController();

    super.initState();
  }

  String emailValidator(String value) {
    String pattern = "[a-zA-z0-9._-]+@[a-z]+\\.+[a-z]+";
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
          'Registration',
          style: GoogleFonts.lobster(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Column(
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
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 400,
                    height: 200,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        elevation: 20,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.black, width: 3)),
                        child: Column(
                          children: <Widget>[
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
                                labelStyle: TextStyle(
                                    fontSize: 15.0, color: Colors.black),
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
                                labelStyle: TextStyle(
                                    fontSize: 15.0, color: Colors.black),
                                hintText: "Enter your Password ",
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              controller: passInputController,
                              validator: pwdValidator,
                            ),
                          ],
                        ),
                      ),
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
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        elevation: 20,
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.black, width: 3)),
                        onPressed: () {
                          if (_registerFormKey.currentState.validate()) {
                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: passInputController.text,
                                  )
                                  .then((currentUser) => Firestore.instance
                                      .collection("user")
                                      .document(currentUser.user.uid)
                                      .setData(
                                        {
                                          "uid": currentUser.user.uid,
                                          "email": emailInputController.text,
                                        },
                                      )
                                      .then(
                                        (result) => {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()),
                                              (_) => false),
                                          emailInputController.clear(),
                                        },
                                      )
                                      .catchError((err) => print(err)));
                            } catch (err) {
                              print(err);
                            }
                          } else {}
                        }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Already have an account "),
                  FlatButton(
                    child: Text("Login here!"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
