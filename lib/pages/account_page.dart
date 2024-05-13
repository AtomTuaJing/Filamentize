import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsAsset.green,
        title: Image.asset("images/logo.png",
            width: 39, height: 39, color: ColorsAsset.white),
      ),
      body: Column(
        children: [
          // user profile + hello user
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 25),
            child: Row(
              children: [
                // user profile
                Icon(
                  Icons.account_circle_outlined,
                  color: ColorsAsset.white,
                  size: 80,
                ),

                SizedBox(width: 5),

                // hello user
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // hello
                    Text(
                      "Hello",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorsAsset.white),
                    ),

                    // username
                    Text(
                      "AtomTuaJing",
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ColorsAsset.white),
                    )
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 45),

          // white container
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 15, top: 45),
              decoration: BoxDecoration(
                  color: ColorsAsset.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                children: [
                  // sign out button
                  Row(
                    children: [
                      // sign out icon
                      Icon(
                        Icons.logout,
                        size: 24,
                        color: ColorsAsset.red,
                      ),

                      SizedBox(width: 10),

                      // sign out
                      Text("Sign out",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorsAsset.red))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
