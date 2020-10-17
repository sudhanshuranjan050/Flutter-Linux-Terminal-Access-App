import 'package:Linux_App/views/home.dart';
import 'package:Linux_App/views/login.dart';
import 'package:Linux_App/views/registration.dart';
import 'package:Linux_App/views/splash.dart';
import 'package:Linux_App/views/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => SplashPage(),
        '/welcome': (BuildContext context) => WelcomePage(),
        '/registration': (BuildContext context) => RegistrationPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage(),
      },
    );
  }
}
