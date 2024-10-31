import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/repositories/post_repositories.dart';
import 'package:softdev_foodblog_frontend/widgets/home_screen/menu_container_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();
  int filterMode = 0; // 0 = no filter, 1 = main, 2 = beverages, 3 = dessert

  Future<List<dynamic>>? filterPost() async {
    debugPrint(
        "Filtering post param: ${searchController.text}, $filterMode, ${priceMinController.text}, ${priceMaxController.text}");
    Map<int, String> filterModeMap = {1: "Main", 2: "Beverages", 3: "Dessert"};
    return PostRepositories().filterPost(
        searchController.text != "" ? searchController.text : null,
        filterMode != 0 ? filterModeMap[filterMode] : null,
        priceMinController.text != "" ? priceMinController.text : null,
        priceMaxController.text != "" ? priceMaxController.text : null);
  }

  @override
  void dispose() {
    searchController.dispose();
    priceMinController.dispose();
    priceMaxController.dispose();
    super.dispose();
  }

  ButtonStyle categoryBtnStyle(int mode) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
          filterMode == mode ? Theme.of(context).primaryColor : Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("ค้นหาสูตรอาหาร",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => searchController.text = value,
                    onEditingComplete: () {
                      setState(() {});
                    },
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
                    onTap: () => showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Container(
                                height: 350,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "ค้นหาตามประเภท",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                            style: categoryBtnStyle(0),
                                            onPressed: () {
                                              setState(() {
                                                filterMode = 0;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("ไม่มี",
                                                style: TextStyle(
                                                  color: filterMode == 0
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                            style: categoryBtnStyle(1),
                                            onPressed: () {
                                              setState(() {
                                                filterMode = 1;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "อาหารจานหลัก",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: filterMode == 1
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                            style: categoryBtnStyle(2),
                                            onPressed: () {
                                              setState(() {
                                                filterMode = 2;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("เครื่องดื่ม",
                                                style: TextStyle(
                                                  color: filterMode == 2
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                )),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: TextButton(
                                            style: categoryBtnStyle(3),
                                            onPressed: () {
                                              setState(() {
                                                filterMode = 3;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text("ของหวาน",
                                                style: TextStyle(
                                                  color: filterMode == 3
                                                      ? Colors.white
                                                      : Theme.of(context)
                                                          .primaryColor,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "ค้นหาตามราคา",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextField(
                                            controller: priceMinController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "ราคาต่ำสุด",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                            flex: 1,
                                            child: Center(child: Text("-"))),
                                        Expanded(
                                          flex: 2,
                                          child: TextField(
                                            controller: priceMaxController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: "ราคาสูงสุด",
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: TextButton(
                                              onPressed: () {
                                                setState(() {});
                                                Navigator.pop(context);
                                              },
                                              child: Text("ค้นหาตามราคา"),
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
            FutureBuilder<List<dynamic>>(
                future: filterPost(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    //debugPrint(snapshot.error.toString());
                    return const Center(
                        child: Text(
                      "ไม่พบข้อมูล !",
                    ));
                  } else if (snapshot.hasData) {
                    List<dynamic> posts = snapshot.data!;
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
                          return menuContainer(
                            context,
                            posts[index],
                            1
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text("No Data"));
                  }
                })
          ],
        ),
      ),
    );
  }
}
