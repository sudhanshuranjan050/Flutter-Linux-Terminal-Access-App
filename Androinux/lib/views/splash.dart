import 'package:Linux_App/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Widget screen = new SplashScreenView(
      imageSrc: "assets/images/linux.png",
      home: WelcomePage(),
      duration: 8000,
      imageSize: 200,
      text: "Linux Terminal",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 40,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen,
    );
  }
}
