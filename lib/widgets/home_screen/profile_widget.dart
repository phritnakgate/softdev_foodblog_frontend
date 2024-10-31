import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softdev_foodblog_frontend/repositories/authen_repositories.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';

import 'menu_container_owner_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool showPosts = true;
  int? userId;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final pref = await SharedPreferences.getInstance();
    final storedUserId = pref.getInt("user_id");
    final storedUserData = pref.getString("user_data");
    debugPrint(storedUserId.toString());
    debugPrint(storedUserData.toString());
    if (storedUserId != null && storedUserData != null) {
      setState(() {
        userId = storedUserId;
        userData = jsonDecode(storedUserData);
      });
    }
  }

  // Example data for "My Posts" and "Liked Posts"
  List<String> myPosts = ['My Post 1', 'My Post 2', 'My Post 3', 'My Post 4'];

  // Example tags
  List<String> tags = ['Breakfast', 'Lunch', 'Dinner'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthenticationRepositories().logout(userId!);
              Navigator.pushReplacementNamed(context, "/");
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text(
          'โปรไฟล์ของคุณ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: userData == null
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('lib/images/burger.png'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "${utf8.decode(userData!["FirstName"].codeUnits)} ${utf8.decode(userData!["LastName"].codeUnits)}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("สูตรอาหารของฉัน", style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: PostRepositories().getPostByUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Error Loading Data"));
                      } else if (snapshot.hasData) {
                        List<dynamic> posts = snapshot.data!;
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
                              return ownerMenuContainer(
                                context,
                                posts[index],
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: Text("No Data"));
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
