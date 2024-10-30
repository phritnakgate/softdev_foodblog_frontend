import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';
import 'package:softdev_foodblog_frontend/widgets/create_recipe_screen/view_ingredient_widget.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  File? _selectedImage;
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController recipeController = TextEditingController();
  TextEditingController timeToCookController = TextEditingController();

  Map<String, dynamic> recipeData = {
    "title": "",
    "detail": "",
    "recipe": "",
    "timetocook": 0,
    "category": 1,
    "image":
        "https://cdn.britannica.com/36/123536-050-95CB0C6E/Variety-fruits-vegetables.jpg",
    "ingredient": [],
    "quantity": [],
  };
  List<Map<String, dynamic>> ingredients = [];
  void addIngredient() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ViewIngredients()));
    if (result != null) {
      setState(() {
        for (var ingredient in result) {
          ingredients.add(ingredient);
          recipeData["ingredient"].add(ingredient["id"]);
          recipeData["quantity"].add(ingredient["quantity"]);
        }

        debugPrint(recipeData.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(recipeData.toString());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "สร้างสูตรอาหาร",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
            child: Form(
              child: Column(
                children: [
                  // Recipe Name Input
                  Row(
                    children: [
                      const Text(
                        "ชื่อ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(
                        width: 45,
                      ), // Spacing between text and field
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: TextFormField(
                            controller: titleController,
                            onChanged: (value) {
                              recipeData["title"] = value;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              filled: true,
                              fillColor: Colors.grey[300],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Category Dropdown
                  Row(
                    children: [
                      const Text(
                        "หมวดหมู่",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              filled: true,
                              fillColor: Colors.grey[300],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text('อาหารจานหลัก'),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('เครื่องดื่ม'),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text('ของหวาน'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                recipeData["category"] = value;
                              });
                            },
                            hint: const Text('เลือกหมวดหมู่'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Image Input
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "รูปภาพอาหาร",
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const ImageInputWidget(),
                  const SizedBox(height: 15),

                  // Details Section
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "รายละเอียด",
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: TextFormField(
                      controller: detailController,
                      onChanged: (value) => recipeData["detail"] = value,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        filled: true,
                        fillColor: Colors.grey[300],
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "วัตถุดิบ",
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  // Ingredient List
                  SizedBox(
                    height: ingredients.isNotEmpty
                        ? 85 * ingredients.length.toDouble()
                        : 5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(ingredients[index]["name"]),
                            subtitle: Text(
                              "${ingredients[index]["quantity"]} ${ingredients[index]["unit"]}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_rounded),
                              onPressed: () {
                                setState(() {
                                  ingredients.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity, // Make the button take full width
                    height: 50, // Adjust the height of the button
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Colors.grey[300], // Set the gray background color
                        side: BorderSide.none, // Remove border
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Circular border
                        ),
                      ),
                      onPressed: () {
                        addIngredient();
                      },
                      child: const Text(
                        '+ เพิ่มวัตถุดิบ',
                        style: TextStyle(
                            color: Colors.black, fontSize: 16), // Text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Instructions Section
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "วิธีทำ",
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextFormField(
                      controller: recipeController,
                      onChanged: (value) => recipeData["recipe"] = value,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          filled: true,
                          fillColor: Colors.grey[300],
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 250,
                        child: Text(
                          "เวลาในการทำโดยประมาณ",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                          child: SizedBox(
                        height: 40.0,
                        child: TextFormField(
                          controller: timeToCookController,
                          onChanged: (value) =>
                              recipeData["timetocook"] = value,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Colors.grey[300],
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      )),
                      const SizedBox(width: 15),
                      const Text(
                        "นาที",
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Create Button
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: const Color(0xFFFEAF30),
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              debugPrint("Data to be sent: $recipeData");
                              PostRepositories().createPost(recipeData).then(
                                (value) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: value
                                              ? Text('สร้างสูตรอาหารสำเร็จ')
                                              : Text('สร้างสูตรอาหารไม่สำเร็จ'),
                                          content: value
                                              ? Text(
                                                  'สูตรอาหารของคุณถูกสร้างเรียบร้อยแล้ว')
                                              : Text('กรุณาลองใหม่อีกครั้ง'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('ตกลง'),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              );
                            },
                            child: const Text(
                              'สร้าง',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildInputField(String label) {
    return Column(
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          width: 100,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300],
          ),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
            ),
          ),
        ),
      ],
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }
}

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({super.key});

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _selectedImage; // To store the selected image file

  Future<void> _pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path); // Store the selected image
        print(returnedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click, // Change the cursor to a pointer
          child: GestureDetector(
            onTap: _pickImage, // Open the image picker when clicked
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(_selectedImage!), // Display the image
                        fit: BoxFit.cover,
                      )
                    : null, // Empty if no image selected
              ),
              child: _selectedImage == null
                  ? const Center(
                      child: Text(
                        'Click to select an image',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )
                  : null, // Placeholder text if no image selected
            ),
          ),
        ),
      ],
    );
  }
}
