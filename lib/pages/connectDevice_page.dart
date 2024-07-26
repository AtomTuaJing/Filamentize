import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ConnectDevicePage extends StatefulWidget {
  final device;
  const ConnectDevicePage({super.key, required this.device});

  @override
  State<ConnectDevicePage> createState() => _ConnectDevicePageState();
}

class _ConnectDevicePageState extends State<ConnectDevicePage> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser;

  // map
  Map<String, dynamic> allBluetooth = {
    "filamentizeStatus": null,
    "filamentizeOne": null,
    "filamentizeTwo": null,
    "filamentizeThree": null,
    "filamentizeSetStatus": null,
    "filamentizeSetMode": null,
    "coolingFan01": null,
    "coolingFan02": null,
    "temp01": null,
    "temp02": null,
    "spoolMotor": null,
    "spoolReset": null,
    "stepper": null,
    "extruder": null,
    "vibrator": null,
    "color": null,
    "otherNotify": null,
    "otherWrite": null
  };

  void connectDevice() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsAsset.green)));

    try {
      // stop scan
      await FlutterBluePlus.stopScan();

      // filamentize variable
      var filamentize = widget.device.device;

      // connect to device
      await filamentize.connect();

      print("reading service");
      context
          .read<FilamentizeData>()
          .changeFilamentizeDevice(device: filamentize);

      // discover all services
      var services = await filamentize.discoverServices();

      // loop through services
      for (var s in services) {
        // check if services length is more than 4
        if (s.serviceUuid.toString().length > 4) {
          // list all characteristics
          var characteristics = s.characteristics;

          // loop through characteristics
          for (var c in characteristics) {
            var descriptors = c.descriptors;

            // variable desciptor
            String? descriptor;

            // loop through descriptors
            for (var d in descriptors) {
              // read descriptor in byte
              var value = await d.read();

              // read descriptor in string
              descriptor = utf8.decode(value);
            }
            print(descriptor);

            // check if descriptor match any prefixes

            // filamentize status notify
            if (descriptor!.contains("filamentizeStatusNotify")) {
              allBluetooth["filamentizeStatus"] = c;
            }
            // filamentize notify one
            else if (descriptor.contains("filamentizeOne")) {
              allBluetooth["filamentizeOne"] = c;
            }
            // filamentize notify two
            else if (descriptor.contains("filamentizeTwo")) {
              allBluetooth["filamentizeTwo"] = c;
            }

            // filamentize notify three
            else if (descriptor.contains("filamentizeThree")) {
              allBluetooth["filamentizeThree"] = c;
            }

            // filamentize set device mode write
            else if (descriptor.contains("filamentizeStatusMode")) {
              allBluetooth["filamentizeSetMode"] = c;
            }

            // filamentize set device status write
            else if (descriptor.contains("filamentizeStatus write")) {
              allBluetooth["filamentizeSetStatus"] = c;
            }

            // filamentize set device status write
            else if (descriptor.contains("reset spool write")) {
              allBluetooth["spoolReset"] = c;
            }

            // spool motor write
            else if (descriptor.contains("spool write")) {
              allBluetooth["spoolMotor"] = c;
            }

            // stepper write
            else if (descriptor.contains("stepper")) {
              allBluetooth["stepper"] = c;
            }

            // extruder write
            else if (descriptor.contains("extruder")) {
              allBluetooth["extruder"] = c;
            }

            // color write
            else if (descriptor.contains("color")) {
              allBluetooth["color"] = c;
            }

            // fan01 write
            else if (descriptor.contains("fan01")) {
              allBluetooth["coolingFan01"] = c;
            }

            // fan02 write
            else if (descriptor.contains("fan02")) {
              allBluetooth["coolingFan02"] = c;
            }

            // temp 01 write
            else if (descriptor.contains("temp01")) {
              allBluetooth["temp01"] = c;
            }

            // temp 02 write
            else if (descriptor.contains("temp02")) {
              allBluetooth["temp02"] = c;
            }

            // vibrator write
            else if (descriptor.contains("vibrator")) {
              allBluetooth["vibrator"] = c;
            }

            // other notify
            else if (descriptor.contains("otherNotify")) {
              allBluetooth["otherNotify"] = c;
            }

            // other write
            else if (descriptor.contains("otherWrite")) {
              allBluetooth["otherWrite"] = c;
            }
          }
        }
      }

      // add characteristics data to provider

      // filamentize status notify
      context.read<FilamentizeData>().changeFilamentizeStatus(
          characteristic: allBluetooth["filamentizeStatus"]);

      // filamentize notify one
      context
          .read<FilamentizeData>()
          .changeFilamentizeOne(characteristic: allBluetooth["filamentizeOne"]);

      // filamentize notify two
      context
          .read<FilamentizeData>()
          .changeFilamentizeTwo(characteristic: allBluetooth["filamentizeTwo"]);

      // filamentize notify three
      context.read<FilamentizeData>().changeFilamentizeThree(
          characteristic: allBluetooth["filamentizeThree"]);

      // set filamentize status
      context.read<FilamentizeData>().changeSetDeviceStatus(
          characteristic: allBluetooth["filamentizeSetStatus"]);

      // set filamentize mode
      context.read<FilamentizeData>().changeSetDeviceMode(
          characteristic: allBluetooth["filamentizeSetMode"]);

      // set cooling fan01
      context
          .read<FilamentizeData>()
          .changeCoolingFan01(characteristic: allBluetooth["coolingFan01"]);

      // set cooling fan02
      context
          .read<FilamentizeData>()
          .changeCoolingFan02(characteristic: allBluetooth["coolingFan02"]);

      // set temp 01
      context
          .read<FilamentizeData>()
          .changeTemp01(characteristic: allBluetooth["temp01"]);

      // set temp 02
      context
          .read<FilamentizeData>()
          .changeTemp02(characteristic: allBluetooth["temp02"]);

      // spool motor reset write
      context
          .read<FilamentizeData>()
          .changeSpoolReset(characteristic: allBluetooth["spoolReset"]);

      // spool motor write
      context
          .read<FilamentizeData>()
          .changeSpoolMotor(characteristic: allBluetooth["spoolMotor"]);

      // stepper motor write
      context
          .read<FilamentizeData>()
          .changeStepper(characteristic: allBluetooth["stepper"]);

      // extruder write
      context
          .read<FilamentizeData>()
          .changeExtruder(characteristic: allBluetooth["extruder"]);

      // color write
      context
          .read<FilamentizeData>()
          .changeColor(characteristic: allBluetooth["color"]);

      // vibrator write
      context
          .read<FilamentizeData>()
          .changeVibrator(characteristic: allBluetooth["vibrator"]);

      // other notify
      context
          .read<FilamentizeData>()
          .changeOtherNotify(characteristic: allBluetooth["otherNotify"]);

      // other write
      context
          .read<FilamentizeData>()
          .changeOtherWrite(characteristic: allBluetooth["otherWrite"]);

      // go to home page & pop loading circle
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      // pop loading circle
      Navigator.pop(context);

      print(e);

      // show error dialog
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                content: Text("Please try again",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: ColorsAsset.green)))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Device Found",
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.w600)),
        leading: IconButton(
            icon: const Icon(Icons.west),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
        child: Column(
          children: [
            // would you like to connect text
            Text(
                "Would you like to connect to ${widget.device.advertisementData.advName}",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsAsset.littleGrey)),

            const SizedBox(height: 14),

            // connection ui
            Container(
              decoration: const BoxDecoration(
                  color: ColorsAsset.grey,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // filamentize machine
                  SizedBox(
                    width: 96,
                    child: Column(
                      children: [
                        // filamentize machine image
                        Image.asset("images/filamentizeMachine.png",
                            width: 96, height: 106),

                        const SizedBox(height: 13),

                        // filamentize machine id
                        Text("Filamentize",
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorsAsset.littleGrey))
                      ],
                    ),
                  ),

                  // bind icon
                  const Icon(Icons.link, size: 30, color: ColorsAsset.green),

                  // account logo + name
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: SizedBox(
                      width: 96,
                      child: Column(
                        children: [
                          // account profile
                          const Icon(Icons.account_circle, size: 48),

                          const SizedBox(height: 36),

                          // account name
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(currentUser!.email)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final user = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  return Text(user["username"],
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorsAsset.littleGrey));
                                } else if (snapshot.hasError) {
                                  return Text("error ${snapshot.error}",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600));
                                } else {
                                  return Text("--",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600));
                                }
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 320),

            // connect button
            GestureDetector(
              onTap: connectDevice,
              child: MyButton(
                text: "Connect",
                color: ColorsAsset.green,
                textColor: Colors.white,
                iconData: Icons.phonelink_ring,
                iconColor: ColorsAsset.white,
                sizedBox: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
