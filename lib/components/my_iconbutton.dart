import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final double rectSize;
  final double iconSize;
  final icon;
  const MyIconButton(
      {super.key,
      required this.rectSize,
      required this.iconSize,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: rectSize,
        height: rectSize,
        decoration: BoxDecoration(
            color: ColorsAsset.green,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Icon(
          icon,
          size: iconSize,
          color: ColorsAsset.white,
        ));
  }
}
