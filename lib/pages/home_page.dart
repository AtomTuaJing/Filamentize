import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/main.dart';
import 'package:filamentize2/pages/addDevice_page.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final currentUser = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get()
        .then((DocumentSnapshot doc) {
      var userData = doc.data() as Map<String, dynamic>;
      if (userData["language"] == "en") {
        localization.translate("en");
      }
      if (userData["language"] == "cn") {
        localization.translate("cn");
      }
      if (userData["language"] == "th") {
        localization.translate("th");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("images/logo.png", width: 39.w, height: 39.h),
        actions: [Icon(Icons.add, size: 29.sp), SizedBox(width: 10.w)],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 15.h),
          child: Column(
            children: [
              SizedBox(height: 25.h),

              // no device yet + image
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // image
                  Image.asset(
                    "images/noDeviceYet.png",
                    width: 200.w,
                    height: 229.h,
                  ),

                  SizedBox(height: 10.h),

                  // no device yet
                  Text(AppLocale.noDeviceYet.getString(context),
                      style: GoogleFonts.montserrat(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsAsset.littleGrey))
                ],
              ),

              SizedBox(height: 39.h),

              // add button
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddDevicePage()));
                },
                child: MyButton(
                  text: AppLocale.add.getString(context),
                  color: ColorsAsset.green,
                  textColor: ColorsAsset.white,
                  iconData: Icons.add,
                  iconColor: ColorsAsset.white,
                  sizedBox: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
