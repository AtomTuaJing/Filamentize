import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';

class MyRecommended extends StatelessWidget {
  final int number;
  const MyRecommended({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 319,
      height: 183,
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
          color: ColorsAsset.red,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(number.toString()),
    );
  }
}
