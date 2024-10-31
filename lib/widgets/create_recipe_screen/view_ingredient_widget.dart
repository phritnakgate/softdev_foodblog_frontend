import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';
import 'package:softdev_foodblog_frontend/widgets/create_recipe_screen/card_ingredient_widget.dart';

class ViewIngredients extends StatefulWidget {
  const ViewIngredients({super.key});

  @override
  State<ViewIngredients> createState() => _ViewIngredientsState();
}

class _ViewIngredientsState extends State<ViewIngredients> {
  List<Map<String, dynamic>> selectedIngredients = [];
  @override
  Widget build(BuildContext context) {
    debugPrint(selectedIngredients.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, selectedIngredients);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("วัตถุดิบ",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Ingredient List
            FutureBuilder<List<dynamic>>(
              future: PostRepositories().getAllIngredients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("การดึงวัตถุดิบผิดพลาด !"));
                } else if (snapshot.hasData) {
                  List<dynamic> ingredients = snapshot.data!;
                  return Expanded(
                    child: GridView.builder(
                      itemCount: ingredients.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return CardIngredient(
                            ingredient: ingredients[index],
                            onConfirm: (ingredientData) {
                              selectedIngredients.add(ingredientData);
                            });
                      },
                    ),
                  );
                } else {
                  return const Center(child: Text("ไม่มีข้อมูล"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
