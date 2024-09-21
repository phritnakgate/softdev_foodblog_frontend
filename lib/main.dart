import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/screens/view_ingredients.dart';
import 'configs/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      home: const ViewIngredients()
    );
  }
}
