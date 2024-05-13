import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("images/logo.png", width: 39, height: 39),
        actions: [Icon(Icons.add, size: 29), SizedBox(width: 10)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
          child: Column(
            children: [
              SizedBox(height: 25),

              // no device yet + image
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // image
                  Image.asset(
                    "images/noDeviceYet.png",
                    width: 200,
                    height: 229,
                  ),

                  SizedBox(height: 10),

                  // no device yet
                  Text("No Device Yet",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ColorsAsset.littleGrey))
                ],
              ),

              SizedBox(height: 39),

              // add button
              MyButton(
                text: "Add",
                color: ColorsAsset.green,
                textColor: ColorsAsset.white,
                iconData: Icons.add,
                iconColor: ColorsAsset.white,
                sizedBox: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
