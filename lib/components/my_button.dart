import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final IconData? iconData;
  final Color? iconColor;
  final double? sizedBox;
  MyButton(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      this.iconData,
      this.iconColor,
      this.sizedBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // icon
          iconData != null
              ? Icon(iconData, color: iconColor)
              : const SizedBox(width: 0),

          sizedBox != null
              ? SizedBox(width: sizedBox)
              : const SizedBox(width: 0),

          // text
          Text(text,
              style: GoogleFonts.montserrat(
                  fontSize: 20, fontWeight: FontWeight.w600, color: textColor)),
        ],
      ),
    );
  }
}
