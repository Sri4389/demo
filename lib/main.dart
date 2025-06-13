import 'package:flutter/material.dart';
import 'screens/login_signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ScreenovaApp());
}

class ScreenovaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screenova',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginSignupScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
