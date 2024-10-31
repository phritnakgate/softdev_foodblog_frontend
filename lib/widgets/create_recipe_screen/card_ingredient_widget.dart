import 'dart:convert';

import 'package:flutter/material.dart';

class CardIngredient extends StatelessWidget {
  final Map<String, dynamic> ingredient;
  final Function(Map<String, dynamic>) onConfirm;

  const CardIngredient(
      {super.key, required this.ingredient, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    TextEditingController quantityController = TextEditingController();
    return Stack(
      children: [
        SizedBox(
          width: 170,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Image.network(
                    ingredient["Picture"],
                    height: 120,
                    width: 140,
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
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    utf8.decode(ingredient["Name"].codeUnits),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 5,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFFFAF30),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              iconSize: 20,
              padding: EdgeInsets.zero,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        title: Text(
                          utf8.decode(ingredient["Name"].codeUnits),
                          textAlign: TextAlign.center, // Title in Thai
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24, // Adjust font size as needed
                          ),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize
                              .min, // To ensure the dialog fits the content
                          children: [
                            SizedBox(
                              width: 100.0, // Set the width of the TextField
                              height: 50.0, // Set the height of the TextField
                              child: TextField(
                                controller: quantityController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  labelText: 'Quantity',
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              utf8.decode(ingredient["Unit"].codeUnits),
                              style: const TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFAF30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'ยืนยัน',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              final quantity =
                                  int.tryParse(quantityController.text) ?? 0;
                              final returnData = {
                                "id": ingredient["ID"],
                                "name":
                                    utf8.decode(ingredient["Name"].codeUnits),
                                "quantity": quantity,
                                "unit":
                                    utf8.decode(ingredient["Unit"].codeUnits),
                              };
                              //debugPrint(returnData.toString());
                              onConfirm(returnData);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ),
      ],
    );
  }
}
