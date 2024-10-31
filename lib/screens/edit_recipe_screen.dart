import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditRecipeScreen extends StatefulWidget {
  const EditRecipeScreen({super.key});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "แก้ไขสูตรอาหาร",
            style: TextStyle(fontWeight: FontWeight.bold,),
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
                  Row(
                    children: [
                      const Text("ชื่อ", style: TextStyle(fontSize: 16.0),),
                      const SizedBox(
                        width: 45,
                      ), // Add spacing between text and field
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
                                  borderSide: const BorderSide(
                                      color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text("หมวดหมู่", style: TextStyle(fontSize: 16.0),),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40.0,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[300],
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
                              // Handle the dropdown value change
                              print(
                                  value); // You can use this to store or process the selected value
                            },
                            hint: const Text(
                                'เลือกหมวดหมู่'), // Placeholder for the dropdown
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("รูปภาพอาหาร", style: TextStyle(fontSize: 16.0),)],
                  ),
                  const SizedBox(height: 5),
                  const ImageInputWidget(),
                  const SizedBox(height: 15),
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
                                  const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const IngredientSection(),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("วิธีทำ", style: TextStyle(fontSize: 16.0),)],
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
                                  const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      const Text("นาที")
                    ],
                  ),
                  const SizedBox(height: 15),
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
                              // Handle edit logic here
                            },
                            child: const Text('แก้ไข'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              // Handle delete logic here
                            },
                            child: const Text('ลบ'),
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
                        style: TextStyle(color: Colors.black, fontSize: 16),
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

class IngredientSection extends StatefulWidget {
  const IngredientSection({super.key});

  @override
  State<IngredientSection> createState() => _IngredientSectionState();
}

class _IngredientSectionState extends State<IngredientSection> {
  // Sample ingredient data
  final List<Map<String, String>> _ingredients = [
    {'name': 'ข้าวสวย', 'amount': '1 ทัพพี'},
    {'name': 'ไข่', 'amount': '1 ฟอง'},
    {'name': 'น้ำมันพืช', 'amount': '1 ช้อนโต๊ะ'},
    {'name': 'ซอสปรุงรส', 'amount': '1 ช้อนชา'},
  ];

  // Function to handle deleting an ingredient
  void _deleteIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  // Function to handle editing an ingredient (for now, it just prints)
  void _editIngredient(int index) {
    print('Edit ingredient at index: $index');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        const Text("วัตถุดิบ", style: TextStyle(fontSize: 16.0),),
        const SizedBox(width: 5),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.black),
          onPressed: () {
            
          },
        )
      ],
    ),
    LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0), // Optional padding for spacing
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
  builder: (BuildContext context, BoxConstraints constraints) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
          ),
          child: DataTable(
            headingRowHeight: 30.0, // Smaller header row height
            columnSpacing: 30.0,
            columns: const [
              DataColumn(
                label: Text(
                  'วัตถุดิบ',
                  style: TextStyle(
                    fontSize: 14.0, // Smaller text size for header
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'ปริมาณ',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(label: SizedBox()), // Empty column for actions
            ],
            rows: _ingredients.map((ingredient) {
              final index = _ingredients.indexOf(ingredient);
              return DataRow(cells: [
                DataCell(Text(ingredient['name']!)),
                DataCell(Text(ingredient['amount']!)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        onPressed: () => _editIngredient(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 18),
                        onPressed: () => _deleteIngredient(index),
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  },
)

        );
      },
    ),
  ],
);

  }
}

