import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDevicePage extends StatelessWidget {
  const AddDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Device",
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.w600)),
        leading: Icon(Icons.west),
        actions: [Icon(Icons.qr_code_scanner), SizedBox(width: 15)],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 55, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // scanning image
            Image.asset("images/scanning.png", width: 248, height: 254),

            SizedBox(height: 24),

            // scanning for device text
            Text("Scanning For Device",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: ColorsAsset.green))
          ],
        ),
      ),
    );
  }
}
