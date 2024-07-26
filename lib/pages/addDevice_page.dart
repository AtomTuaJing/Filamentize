import 'dart:io';

import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/pages/connectDevice_page.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
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
            if (result.advertisementData.advName.contains("YedHod")) {
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
        title: Text("Add Device",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 55, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // scanning image
            Image.asset("images/scanning.png", width: 248, height: 254),

            const SizedBox(height: 24),

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
