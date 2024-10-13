import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/screens/home_screen.dart';
import 'package:softdev_foodblog_frontend/configs/theme.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
