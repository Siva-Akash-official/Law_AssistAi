import 'package:flutter/material.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/LoginScreen.dart';// Import the second screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LawAssist Ai',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    routes: {
    '/login': (context) => LoginScreen()}// Set FirstScreen as the home screen
    );
  }
}
