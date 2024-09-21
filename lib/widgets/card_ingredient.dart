import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/model/ingredient.dart';

class CardIngredient extends StatelessWidget {
  final Ingredient ingredient;

  CardIngredient({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 200,
          child: Card(
            elevation: 4, // Add shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Make it stretch to fill width
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    ingredient.url,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ingredient.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.orange,
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // Action when plus button is pressed
              },
            ),
          ),
        ),
      ],
    );
  }
}
