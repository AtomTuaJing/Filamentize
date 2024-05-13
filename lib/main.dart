import "package:filamentize2/pages/addDevice_page.dart";
import "package:filamentize2/pages/connectDevice_page.dart";
import "package:filamentize2/pages/coupons_page.dart";
import "package:filamentize2/pages/home_page_connected.dart";
import "package:filamentize2/pages/useCoupon_page.dart";
import "package:filamentize2/services/navigation.dart";
import "package:filamentize2/services/signIn_or_signUp.dart";
import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
  }
}
