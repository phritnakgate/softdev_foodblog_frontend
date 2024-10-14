import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/screens/create_recipe_screen.dart';
import 'package:softdev_foodblog_frontend/screens/edit_recipe_screen.dart';
import 'configs/theme.dart';

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
      initialRoute: '/edit_recipe',
      routes: {
        '/create_recipe': (context) => const CreateRecipe(),
        '/edit_recipe': (context) => const EditRecipe(),
      },
    );
  }
}
