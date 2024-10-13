import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:iconify_flutter/icons/uil.dart';

class ViewRecipeScreen extends StatelessWidget {
  const ViewRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Vivat T.",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                  ],
                ),
                const Text("ข้าวผัดไข่",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                tagsContainer(context, "อาหารเช้า"),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://www.maggi.co.th/sites/default/files/srh_recipes/a1b6cab9710d963ab0d30f62e5d3a88a.jpeg",
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
                        onPressed: () {}, icon: const Iconify(Uil.comment)),
                    IconButton(
                        onPressed: () {}, icon: const Iconify(Tabler.send)),
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Text(
                    "มาลองทำ “ข้าวผัดไข่” (Egg Fried Rice) เมนูข้าวผัดสไตล์จีนที่ทำง่ายมาก ๆ ใช้เวลาไม่ถึง 15 นาทีก็พร้อมกินแล้ว! ฟังดูง่ายเหลือเชื่อเลยใช่ไหมล่ะคะ นอกจากนี้สูตรข้าวผัดไข่ของเราจะมาเฉลยเคล็ดลับวิธีผัดข้าวผัด ผัดยังไงให้ข้าวร่วนเป็นเม็ดสวย ไม่แฉะ รับรองว่ามือใหม่อย่างเราก็สามารถทำกันได้ง่าย ๆ ที่บ้านเลย แถมส่วนผสมข้าวผัดในวันนี้ก็มีแค่ข้าวสวยและไข่ไก่เท่านั้นเองค่ะ ปรุงรสอีกนิด ๆ หน่อย ๆ ก็เรียบร้อย ถ้าพร้อมกันแล้วก็ไปล้างไม้ล้างมือเตรียมเข้าครัวกันเลยยย!",
                    style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("วัตถุดิบ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Iconify(Mdi.fire, color: Colors.grey[700]),
                    Text("200 กิโลแคลอรี่",
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(
                      width: 10,
                    ),
                    Iconify(Mdi.money, color: Colors.grey[700]),
                    Text("30 บาท", style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
                const Text("ไข่ข้าว", style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("ขั้นตอนการทำ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Iconify(Mdi.clock, color: Colors.grey[700]),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "15 นาที",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                const Text("1. อิอิ\n2.อิอิ\n3.อิอิ\n4.อิอิ",
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget tagsContainer(BuildContext context, String tag) {
  return Container(
    width: 100,
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
        tag,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
