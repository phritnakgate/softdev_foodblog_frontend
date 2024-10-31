import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:page_transition/page_transition.dart';

import '../../screens/view_recipe_screen.dart';

Widget bookmarkedMenuContainer(
    BuildContext context, Map<String, dynamic> data) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: ViewRecipeScreen(id: data["PostID"], fromWhatPage: 3),
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
              data["Post"]["Picture"],
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
                  utf8.decode(data["Post"]["Title"].codeUnits),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Iconify(Mdi.fire),
                    const SizedBox(width: 5),
                    Text(
                      "${data["Post"]["Calories"]} กิโลแคลอรี่",
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
                      "${data["Post"]["Price"]} บาท",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
