import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ค้นหาสูตรอาหาร",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) => setState(() {
                          searchController.text = value;
                        }),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(242, 242, 247, 1),
                          hintText: "ค้นหาสูตรอาหาร",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    offset: const Offset(0, 5))
                              ]),
                          child: const Icon(Icons.filter_alt_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(searchController.text.isEmpty
                    ? "กรอกข้อมูล"
                    : searchController.text),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ));
  }
}

Widget categoryBtn(String title, bool isSelected) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 5))
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16, color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}
