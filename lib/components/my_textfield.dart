import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  final IconData iconData;
  final TextEditingController textEditingController;
  final String hintText;

  MyTextField(
      {super.key,
      required this.iconData,
      required this.textEditingController,
      required this.hintText});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: ColorsAsset.littleGrey, width: 1))),
        child: TextField(
          controller: widget.textEditingController,
          cursorColor: ColorsAsset.green,
          style:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              icon: Icon(widget.iconData),
              iconColor: ColorsAsset.dark,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent)),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorsAsset.littleGrey)),
        ));
  }
}
