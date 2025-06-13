import 'package:flutter/material.dart';
import 'package:myapp/models/product_model.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:myapp/screens/product_detail_screen.dart';
import 'package:myapp/screens/splash_screen.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/Onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginSignupScreen(),
        '/home': (context) => HomeScreen(),
        '/productDetail': (context) => ProductDetailScreen(
          product: ModalRoute.of(context)!.settings.arguments as Product,
        ),
      },
    );
  }
}
