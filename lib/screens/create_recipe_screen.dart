import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                      const Text("ชื่อ", style: TextStyle(fontSize: 16.0),),
                      const SizedBox(
                          width: 45,), // Spacing between text and field
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: TextFormField(
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
                      const Text("หมวดหมู่", style: TextStyle(fontSize: 16.0),),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: DropdownButtonFormField<String>(
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
                                value: 'อาหารทานเล่น',
                                child: Text('อาหารทานเล่น'),
                              ),
                              DropdownMenuItem(
                                value: 'อาหารมื้อหลัก',
                                child: Text('อาหารมื้อหลัก'),
                              ),
                              DropdownMenuItem(
                                value: 'อาหาร...',
                                child: Text('อาหาร...'),
                              ),
                            ],
                            onChanged: (value) {
                              print(value);
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
                    children: [Text("รูปภาพอาหาร", style: TextStyle(fontSize: 16.0),)],
                  ),
                  const SizedBox(height: 5),
                  const ImageInputWidget(),
                  const SizedBox(height: 15),

                  // Details Section
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("รายละเอียด", style: TextStyle(fontSize: 16.0),)],
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: TextFormField(
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
                    children: [Text("วัตถุดิบ", style: TextStyle(fontSize: 16.0),)],
                  ),
                  const SizedBox(height: 5),
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
                        // Handle adding ingredients here
                      },
                      child: const Text(
                        '+ เพิ่มวัตถุดิบ',
                        style: TextStyle(color: Colors.black, fontSize: 16), // Text color
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Instructions Section
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("วิธีทำ", style: TextStyle(fontSize: 16.0),)],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextFormField(
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
                      const SizedBox(width: 250, child: Text("เวลาในการทำโดยประมาณ", style: TextStyle(fontSize: 16.0),),),
                      const SizedBox(width: 20),
                      Expanded(
                          child: SizedBox(
                        height: 40.0,
                        child: TextFormField(
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
                      const Text("นาที", style: TextStyle(fontSize: 16.0),)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text("แคลอรี่โดยประมาณ", style: TextStyle(fontSize: 16.0),),
                          const SizedBox(height: 5),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300],
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              // style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("ราคาโดยประมาณ", style: TextStyle(fontSize: 16.0),),
                          const SizedBox(height: 5),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[300],
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              // style: const TextStyle(fontSize: 14),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                              // Handle recipe creation logic
                            },
                            child: const Text('สร้าง', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
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