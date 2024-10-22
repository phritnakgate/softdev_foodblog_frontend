import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/model/ingredient.dart';
import 'package:softdev_foodblog_frontend/widgets/card_ingredient.dart';

class ViewIngredients extends StatefulWidget {
  const ViewIngredients({super.key});

  @override
  State<ViewIngredients> createState() => _ViewIngredientsState();
}

class _ViewIngredientsState extends State<ViewIngredients> {
  int selectedIndex = 0; 
  final List<String> categories = ['ข้าว/เส้น', 'เนื้อสัตว์', 'ผัก', 'เครื่องปรุง', 'ผลไม้'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text("Ingredients"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar at the top
            SearchAnchor(
              viewHintText: 'Search here...',
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 18.0)),
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFFFAF30)),
                  controller: controller,
                  hintText: "what are you looking for?",
                  hintStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                // Return a list of suggestions here
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'Test $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
            const SizedBox(height: 20),
            //Ingredient types
            SizedBox(
              height: 50, // Set a fixed height for horizontal scroll
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // Add actual buttons or widgets for ingredient types
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: index == selectedIndex
                            ? const Color(0xFFFFAF30) // Active state for the first button
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: Text(
                        categories[index],
                                    
                        style: TextStyle(
                          color: index == selectedIndex ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            
            // Ingredient List
            Expanded( 
              child: GridView.builder(
                itemCount: 24,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,
                itemBuilder: (context, index) {
                  Ingredient ingredient = Ingredient(name: "บะหมี่เหลือง", url: "lib/images/kao.webp", unit: "10");
                  return CardIngredient(
                    ingredient: ingredient,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
