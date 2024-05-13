import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBestDeal extends StatelessWidget {
  const MyBestDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 151,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: ColorsAsset.red),
    );
  }
}
