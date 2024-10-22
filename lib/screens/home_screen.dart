import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:softdev_foodblog_frontend/widgets/home_screen/home_widgets.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  void onBottomNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> widgetOptions = <Widget>[
    const HomeWidget(),
    const SearchWidget(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: onBottomNavTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Iconify(
                Majesticons.home_line,
                color: selectedIndex == 0
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
              ),
              label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Iconify(
              Bi.person,
              color: selectedIndex == 4
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
