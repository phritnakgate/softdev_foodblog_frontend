import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softdev_foodblog_frontend/configs/theme.dart';
import 'package:softdev_foodblog_frontend/repositories/authen_repositories.dart';
import 'package:softdev_foodblog_frontend/widgets/home_screen/home_widgets.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // UNCOMMENT THIS TO CLEAR JWT TOKEN AND JWT EXPIRED DATE
    //AuthenticationRepositories().clearUserData();
    AuthenticationRepositories().isTokenExpired().then((value) {
      if (value) {
        AuthenticationRepositories().clearUserData();
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileWidget(),
      },
    );
  }
}
