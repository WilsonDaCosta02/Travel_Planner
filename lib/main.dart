import 'package:flutter/material.dart';
import 'package:project_travelplanner/login.dart';
import 'package:project_travelplanner/screens/destination_screen.dart';
import 'package:project_travelplanner/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        '/register': (context) => const Register(),
        '/destinations': (context) => const DestinationScreen(),
      },
    );
  }
}
