import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';

import 'menu_container_bookmark_widget.dart';

class BookmarkWidget extends StatefulWidget {
  const BookmarkWidget({super.key});

  @override
  State<BookmarkWidget> createState() => _BookmarkWidgetState();
}

class _BookmarkWidgetState extends State<BookmarkWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("สูตรที่บันทึกไว้",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          FutureBuilder(
            future: PostRepositories().getBookmarks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Loading Data"));
              } else if (snapshot.hasData) {
                List<dynamic> posts = snapshot.data!;
                //debugPrint("Bookmarked Posts: $posts");
                if (posts.isEmpty) {
                  return const Center(child: Text("ไม่มีสูตรที่บันทึกไว้ :D"));
                } else {
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return bookmarkedMenuContainer(
                          context,
                          posts[index],
                        );
                      },
                    ),
                  );
                }
              } else {
                return const Center(child: Text("No Data"));
              }
            },
          ),
        ],
      ),
    ));
  }
}
