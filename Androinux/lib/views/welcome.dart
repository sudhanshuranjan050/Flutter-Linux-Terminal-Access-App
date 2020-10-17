import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome",
                style: GoogleFonts.lobster(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
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
                height: 100,
              ),
              SizedBox(
                width: 200,
                child: RaisedButton(
                    color: Colors.white,
                    elevation: 0,
                    child: Text(
                      'Registration',
                    ),
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(130.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/registration");
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: RaisedButton(
                    color: Colors.white,
                    elevation: 0,
                    child: Text(
                      'Login',
                    ),
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(130.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 4,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    }),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
