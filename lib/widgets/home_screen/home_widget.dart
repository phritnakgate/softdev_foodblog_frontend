import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/widgets/home_screen/menu_container_widget.dart';

import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text("ค้นหาสูตรอาหารใหม่ๆได้ที่นี่ !",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
                future: PostRepositories().getAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error Loading Data"));
                  } else if (snapshot.hasData) {
                    List<dynamic> posts = snapshot.data!;
                    //debugPrint(posts[0].toString());
                    return Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return menuContainer(
                            context,
                            posts[index],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text("No Data"));
                  }
                }),
          ],
        ),
      ),
    );
  }
}

//ในอนาคตอาจเปลี่ยนเป็น data model จาก API แทนการใช้ List แบบนี้

