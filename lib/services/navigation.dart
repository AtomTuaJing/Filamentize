import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/pages/account_page.dart';
import 'package:filamentize2/pages/game_page.dart';
import 'package:filamentize2/pages/home_page.dart';
import 'package:filamentize2/pages/shop_page.dart';
import 'package:filamentize2/services/filamentize_or_molding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final bool connectionState;
  const Navigation({super.key, required this.connectionState});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      widget.connectionState ? const FilamentizeOrMolding() : const HomePage(),
      const ShopPage(),
      GamePage(),
      const AccountPage()
    ];
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedIconTheme: const IconThemeData(color: ColorsAsset.green),
        unselectedIconTheme: const IconThemeData(color: ColorsAsset.littleGrey),
        backgroundColor: ColorsAsset.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Apps"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: "Shop"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports_outlined), label: "Game"),
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
