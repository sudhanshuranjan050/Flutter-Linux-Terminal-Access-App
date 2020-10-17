import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  TextEditingController command = TextEditingController();
  var input;

  @override
  void initState() {
    super.initState();
    firestoreInstance.collection("data").doc(firebaseUser.uid).set({
      "Result": "",
      "statusCode": "",
    });
  }

  getOutput(input) async {
    var url = 'http://192.168.43.102/cgi-bin/linux.py?x=$input';
    var result = await http.get(url);
    var output = json.decode(result.body);

    await firestoreInstance.collection("data").doc(firebaseUser.uid).set({
      "Result": output['Result'],
      "statusCode": output['statusCode']
    }).then((_) => print("Sucess"));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: RotateAnimatedTextKit(
                  totalRepeatCount: 2000,
                  text: ["Linux Terminal"],
                  textStyle: GoogleFonts.lobster(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: command,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Enter command",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Do not leave blank';
                          }
                          input = value;
                          return null;
                        },
                      ),
                    ),
                    Center(
                        child: SizedBox(
                      width: 300,
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            getOutput(input);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.black, width: 3)),
                        label: Text("Submit"),
                        backgroundColor: Colors.blue,
                        icon: Icon(Icons.fast_forward),
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              StreamBuilder(
                stream: firestoreInstance
                    .collection("data")
                    .doc(firebaseUser.uid)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Text("No Data");
                  else {
                    var info = snapshot.data.data();
                    // print(info['ContainerID']);
                    return SingleChildScrollView(
                      child: Container(
                        width: (MediaQuery.of(context).size.width) * 0.95,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (info['Result'] != null) ? info['Result'] : "",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                color: Colors.yellow,
                                style: BorderStyle.solid)),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
