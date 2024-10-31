import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:softdev_foodblog_frontend/repositories/authen_repositories.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';

class ViewRecipeScreen extends StatefulWidget {
  const ViewRecipeScreen(
      {required this.id, required this.fromWhatPage, super.key});

  final int id;
  final int fromWhatPage;
  
  @override
  State<ViewRecipeScreen> createState() => _ViewRecipeScreenState();
}

class _ViewRecipeScreenState extends State<ViewRecipeScreen> {
  bool isLogin = false;
  int userId = 0;
  bool isBookmarked = false;
  bool isLiked = false;
  late Future<Map<String, dynamic>> _postDetailsFuture;

  @override
  void initState() {
    super.initState();
    _postDetailsFuture = PostRepositories().getPostById(widget.id);
    // debugPrint(_postDetailsFuture.toString());
    AuthenticationRepositories().isLogin().then((value) {
      setState(() {
        isLogin = value;
      });
    });
    AuthenticationRepositories().getUserId().then((value) {
      setState(() {
        userId = value;
      });
    });
    PostRepositories().isBookmarked(widget.id).then((value) {
      setState(() {
        isBookmarked = value;
      });
    });
    PostRepositories().isLiked(widget.id).then((value) {
      setState(() {
        isLiked = value;
      });
    });
  }

  void handleComment(text) {
    PostRepositories().commented(text, widget.id.toString()).then((_){
     setState(() {
       _postDetailsFuture = PostRepositories().getPostById(widget.id);
       Navigator.pop(context);
       openCommentsModal();
     });
    });

  }

  void likeRecipe() {
    PostRepositories().likes(widget.id).then((_) {
      setState(() {
        isLiked = !isLiked;
        _postDetailsFuture = PostRepositories().getPostById(widget.id);
      });
    });
  }

  void handleBookmark() {
    PostRepositories().bookmark(widget.id);
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }
  void openCommentsModal() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      TextEditingController commentController = TextEditingController();
      return Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 300,
            child: Column(
              children: [
                const Text(
                  "ความคิดเห็น",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: _postDetailsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text("Error loading comments");
                    } else {
                      List comments = snapshot.data!["PostComments"];
                      return comments.isEmpty
                          ? const Text("ยังไม่มีความคิดเห็น")
                          : Expanded(
                              child: ListView.builder(
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  return commentContainer(
                                    comments[index]["User"]["Username"],
                                    utf8.decode(comments[index]["Comment"]["Comment"].codeUnits),
                                  );
                                },
                              ),
                            );
                    }
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(hintText: "แสดงความคิดเห็น"),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isLogin) {
                          handleComment(commentController.text);
                          commentController.clear();
                        } else {
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    // debugPrint("isLogin: $isLogin, User ID: $userId");
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pushReplacementNamed(context, "/",
                  arguments: widget.fromWhatPage),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
            future: _postDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error Loading Data"));
              } else if (snapshot.hasData) {
                Map<String, dynamic> details = snapshot.data!;
                //debugPrint(details.toString());
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${utf8.decode(details["User"]["FirstName"].codeUnits)} ${utf8.decode(details["User"]["LastName"].codeUnits)}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[700]),
                              ),
                              const Spacer(),
                              if (userId == details["User"]["Id"])
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit))
                            ],
                          ),
                          Text(utf8.decode(details["Title"].codeUnits),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold)),
                          tagsContainer(context, details["Category"]["Type"]),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              details["Picture"],
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    isLogin
                                        ? likeRecipe()
                                        : Navigator.pushNamed(
                                            context, '/login');
                                  },
                                  icon: isLiked
                                      ? const Icon(Icons.favorite,
                                          color: Colors.red)
                                      : const Icon(Icons.favorite_border)),
                              Text(details["Like"].length.toString()),
                              IconButton(
                                  onPressed: () {
                                    openCommentsModal();
                                  }
                                  ,
                                  icon: const Iconify(Uil.comment)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Iconify(Tabler.send)),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  isLogin
                                      ? handleBookmark()
                                      : Navigator.pushNamed(context, '/login');
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: isBookmarked
                                      ? const Icon(Icons.bookmark)
                                      : const Icon(Icons.bookmark_border),
                                ),
                              ),
                            ],
                          ),
                          const Text("รายละเอียด",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(utf8.decode(details["Detail"].codeUnits),
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("วัตถุดิบ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Iconify(Mdi.fire, color: Colors.grey[700]),
                              Text("${details["Calories"]} กิโลแคลอรี่",
                                  style: TextStyle(color: Colors.grey[700])),
                              const SizedBox(
                                width: 10,
                              ),
                              Iconify(Mdi.money, color: Colors.grey[700]),
                              Text("${details["Price"]} บาท",
                                  style: TextStyle(color: Colors.grey[700])),
                            ],
                          ),
                          for (int i = 0;
                              i < details["Ingredients"].length;
                              i++)
                            ingredientContainer(
                                context, details["Ingredients"][i]),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text("ขั้นตอนการทำ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              Iconify(Mdi.clock, color: Colors.grey[700]),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${details["TimeToCook"]} นาที",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          Text(utf8.decode(details["Recipe"].codeUnits),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

Widget tagsContainer(BuildContext context, String tag) {
  //debugPrint(tag);
  Map<String, String> tagName = {
    "Main": "อาหารจานหลัก",
    "Dessert": "ของหวาน",
    "Beverages": "เครื่องดื่ม",
  };
  return Container(
    width: 120,
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
        tagName[utf8.decode(tag.codeUnits)]!,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget ingredientContainer(
    BuildContext context, Map<String, dynamic> ingredient) {
  //debugPrint(ingredient.toString());
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  utf8.decode(ingredient["IngredientWithQuantity"]["Ingredient"]
                          ["Name"]
                      .codeUnits),
                  style: const TextStyle(fontSize: 16)),
              Text(
                  "${ingredient["IngredientWithQuantity"]["Quantity"]} ${utf8.decode(ingredient["IngredientWithQuantity"]["Ingredient"]["Unit"].codeUnits)}"),
            ],
          ),
        )),
  );
}

Widget commentContainer(String fullName, String commentText) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(commentText),
          ],
        ),
      ],
    ),
  );
}
