import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';

class ViewRecipeScreen extends StatelessWidget {
  const ViewRecipeScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: PostRepositories().getPostById(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Loading Data"));
              } else if (snapshot.hasData) {
                Map<String, dynamic> details = snapshot.data!;
                debugPrint(details.toString());
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${utf8.decode(details["User"]["FirstName"].codeUnits)} ${utf8.decode(details["User"]["LastName"].codeUnits)}.",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[700]),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit))
                            ],
                          ),
                          Text(utf8.decode(details["Title"].codeUnits),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold)),
                          tagsContainer(context, details["Category"]["Type"]),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              details["Picture"],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Iconify(Uil.comment)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Iconify(Tabler.send)),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(Icons.bookmark_outline),
                                ),
                              ),
                            ],
                          ),
                          const Text("รายละเอียด",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(utf8.decode(details["Detail"].codeUnits),
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("วัตถุดิบ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Iconify(Mdi.fire, color: Colors.grey[700]),
                              Text("${details["Calories"]} กิโลแคลอรี่",
                                  style: TextStyle(color: Colors.grey[700])),
                              const SizedBox(
                                width: 10,
                              ),
                              Iconify(Mdi.money, color: Colors.grey[700]),
                              Text("${details["Price"]} บาท",
                                  style: TextStyle(color: Colors.grey[700])),
                            ],
                          ),
                          for (int i = 0;
                              i < details["Ingredients"].length;
                              i++)
                            ingredientContainer(
                                context, details["Ingredients"][i]),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("ขั้นตอนการทำ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Iconify(Mdi.clock, color: Colors.grey[700]),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${details["TimeToCook"]} นาที",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          Text(utf8.decode(details["Recipe"].codeUnits),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

Widget tagsContainer(BuildContext context, String tag) {
  //debugPrint(tag);
  Map<String, String> tagName = {
    "Main": "อาหารจานหลัก",
    "Dessert": "ของหวาน",
    "Beverages": "เครื่องดื่ม",
  };
  return Container(
    width: 120,
    height: 30,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 5,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: Center(
      child: Text(
        tagName[utf8.decode(tag.codeUnits)]!,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget ingredientContainer(
    BuildContext context, Map<String, dynamic> ingredient) {
  //debugPrint(ingredient.toString());
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  utf8.decode(ingredient["IngredientWithQuantity"]["Ingredient"]
                          ["Name"]
                      .codeUnits),
                  style: const TextStyle(fontSize: 16)),
              Text(
                  "${ingredient["IngredientWithQuantity"]["Quantity"]} ${utf8.decode(ingredient["IngredientWithQuantity"]["Ingredient"]["Unit"].codeUnits)}"),
            ],
          ),
        )),
  );
}
