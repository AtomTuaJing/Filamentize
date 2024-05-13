import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectDevicePage extends StatelessWidget {
  const ConnectDevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Connect Device",
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.w600)),
        leading: Icon(Icons.west),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
        child: Column(
          children: [
            // would you like to connect text
            Text("Would you like to connect to Filamentize#ABC1",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsAsset.littleGrey)),

            SizedBox(height: 14),

            // connection ui
            Container(
              decoration: BoxDecoration(
                  color: ColorsAsset.grey,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // filamentize machine
                  Container(
                    width: 96,
                    child: Column(
                      children: [
                        // filamentize machine image
                        Image.asset("images/filamentizeMachine.png",
                            width: 96, height: 106),

                        SizedBox(height: 13),

                        // filamentize machine id
                        Text("#ABC1",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorsAsset.littleGrey))
                      ],
                    ),
                  ),

                  // bind icon
                  Icon(Icons.link, size: 30, color: ColorsAsset.green),

                  // account logo + name
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Container(
                      width: 96,
                      child: Column(
                        children: [
                          // account profile
                          Icon(Icons.account_circle, size: 48),

                          SizedBox(height: 36),

                          // account name
                          Text("Atom",
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsAsset.littleGrey))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 320),

            // connect button
            MyButton(
              text: "Connect",
              color: ColorsAsset.green,
              textColor: Colors.white,
              iconData: Icons.phonelink_ring,
              iconColor: ColorsAsset.white,
              sizedBox: 5,
            )
          ],
        ),
      ),
    );
  }
}
