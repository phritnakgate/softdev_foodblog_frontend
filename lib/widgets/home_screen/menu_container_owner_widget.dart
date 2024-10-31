import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';

import '../../screens/view_recipe_screen.dart';

Widget ownerMenuContainer(BuildContext context, Map<String, dynamic> data) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ViewRecipeScreen(id: data["ID"], fromWhatPage: 4),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              data["Picture"],
              height: 107,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  "https://bitsofco.de/img/Qo5mfYDE5v-350.png",
                  height: 107,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  utf8.decode(data["Title"].codeUnits),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Iconify(Mdi.fire),
                    const SizedBox(width: 5),
                    Text(
                      "${data["Calories"]} กิโลแคลอรี่",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Iconify(Mdi.money),
                    const SizedBox(width: 5),
                    Text(
                      "${data["Price"]} บาท",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("ยืนยันการลบสูตรอาหาร"),
                            content: const Text(
                                "คุณต้องการลบสูตรอาหารนี้ใช่หรือไม่?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("ยกเลิก"),
                              ),
                              TextButton(
                                onPressed: () {
                                  PostRepositories().deletePost(data["ID"]);
                                  Navigator.pushReplacementNamed(context, "/",
                  arguments: 4);
                                },
                                child: const Text("ยืนยัน"),
                              ),
                            ],
                          );
                        });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(Icons.delete_rounded),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
