import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../screens/view_recipe_screen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text("ค้นหาสูตรอาหารใหม่ๆได้ที่นี่ !",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("สูตรอาหารยอดนิยม",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text("ดูทั้งหมด")),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 256,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Adjust this based on the number of items
                  itemBuilder: (context, index) {
                    return menuContainer(
                        context,
                        "ข้าวผัดไข่",
                        "https://www.maggi.co.th/sites/default/files/srh_recipes/a1b6cab9710d963ab0d30f62e5d3a88a.jpeg",
                        500,
                        50);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("แยกตามประเภท",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text("ดูทั้งหมด")),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4, // Adjust this based on the number of items
                  itemBuilder: (context, index) {
                    return categoryBtn("Test", index == 0);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 256,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3, // Adjust this based on the number of items
                  itemBuilder: (context, index) {
                    return menuContainer(
                        context,
                        "ข้าวผัดไข่",
                        "https://www.maggi.co.th/sites/default/files/srh_recipes/a1b6cab9710d963ab0d30f62e5d3a88a.jpeg",
                        500,
                        50);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//ในอนาคตอาจเปลี่ยนเป็น data model จาก API แทนการใช้ List แบบนี้
Widget menuContainer(
    BuildContext context, String title, String imageUrl, int cal, int price) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const ViewRecipeScreen(),
        ),
      );
    },
    child: Container(
      width: 196,
      height: 256,
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
              imageUrl,
              height: 107,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department),
                    Text(
                      "$cal กิโลแคลอรี่",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.attach_money),
                    Text(
                      "$price บาท",
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
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
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
