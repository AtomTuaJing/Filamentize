import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/main.dart';
import 'package:filamentize2/pages/connectDevice_page.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
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
    var subscription = FlutterBluePlus.adapterState
        .listen((BluetoothAdapterState state) async {
      print(state);
      if (state == BluetoothAdapterState.on) {
        // scan for filamentize
        FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
        FlutterBluePlus.onScanResults.listen((results) {
          if (results.isNotEmpty) {
            var result = results.last;
            if (result.advertisementData.advName.contains("Filamentize")) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConnectDevicePage(device: result)));
            }
          }
        });
      } else {
        if (Platform.isAndroid) {
          await FlutterBluePlus.turnOn();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocale.addDevice.getString(context),
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.west),
          onPressed: () async {
            await FlutterBluePlus.stopScan();
            Navigator.pop(context);
          },
        ),
        actions: const [Icon(Icons.qr_code_scanner), SizedBox(width: 15)],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 25.h),
          child: Column(
            children: [
              // scanning image
              Center(
                  child: Image.asset("images/scanning.png",
                      width: 248.w, height: 254.h)),

              SizedBox(height: 24.h),

              // scanning for device text
              Text(AppLocale.scanningForDevice.getString(context),
                  style: GoogleFonts.montserrat(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsAsset.green))
            ],
          ),
        ),
      ),
    );
  }
}
