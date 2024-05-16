import 'package:filamentize2/pages/home_page_connected.dart';
import 'package:filamentize2/pages/home_page_connected_mo.dart';
import 'package:flutter/material.dart';

class FilamentizeOrMolding extends StatefulWidget {
  const FilamentizeOrMolding({super.key});

  @override
  State<FilamentizeOrMolding> createState() => _FilamentizeOrMoldingState();
}

class _FilamentizeOrMoldingState extends State<FilamentizeOrMolding> {
  // initially set to filamentize page
  bool isShowFilamentize = true;

  // method to switch page
  void toggleFilamentizePage() {
    setState(() {
      isShowFilamentize = !isShowFilamentize;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShowFilamentize == true) {
      return HomePageConnected(toggleFilamentize: toggleFilamentizePage);
    } else {
      return HomePageConnectedMo(toggleFilamentize: toggleFilamentizePage);
    }
  }
}
