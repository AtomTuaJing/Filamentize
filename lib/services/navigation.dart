import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/pages/account_page.dart';
import 'package:filamentize2/pages/home_page.dart';
import 'package:filamentize2/pages/home_page_connected.dart';
import 'package:filamentize2/pages/shop_page.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> tabs = [HomePageConnected(), ShopPage(), AccountPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedIconTheme: IconThemeData(color: ColorsAsset.green),
        backgroundColor: ColorsAsset.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Apps"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: "Shop"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Person")
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
