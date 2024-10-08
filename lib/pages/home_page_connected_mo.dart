import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_iconbutton.dart';
import 'package:filamentize2/components/my_molding.dart';
import 'package:filamentize2/components/my_slider.dart';
import 'package:filamentize2/components/my_temp.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageConnectedMo extends StatefulWidget {
  final Function()? toggleFilamentize;
  final Function()? toggleStatus;
  final String filamentizeStatus;
  const HomePageConnectedMo(
      {super.key,
      required this.toggleFilamentize,
      required this.toggleStatus,
      required this.filamentizeStatus});

  @override
  State<HomePageConnectedMo> createState() => _HomePageConnectedMoState();
}

class _HomePageConnectedMoState extends State<HomePageConnectedMo> {
  int temp01 = 0;
  int temp02 = 0;
  int setTemp01 = 0;
  int setTemp02 = 0;
  double setFanOne = 0;
  double setFanTwo = 0;
  double spoolMotor = 0;
  double extruder = 0;
  double stepper = 0;
  String color = "";
  var selectedColor = "";

  var Options;

  @override
  void didChangeDependencies() {
    Options = [
      AppLocale.white.getString(context),
      AppLocale.black.getString(context),
      AppLocale.red.getString(context),
      AppLocale.green.getString(context),
      AppLocale.blue.getString(context),
      AppLocale.yellow.getString(context),
      AppLocale.cyan.getString(context),
      AppLocale.magenta.getString(context),
      AppLocale.purple.getString(context),
      AppLocale.brown.getString(context),
      AppLocale.orange.getString(context),
      AppLocale.gray.getString(context),
      AppLocale.limeGreen.getString(context),
      AppLocale.navyBlue.getString(context),
      AppLocale.silver.getString(context),
      AppLocale.maroon.getString(context)
    ];
    if (context.watch<FilamentizeData>().filamentizeThree != null) {
      context.read<FilamentizeData>().filamentizeThree!.setNotifyValue(true);
    }
    if (context.watch<FilamentizeData>().filamentizeOne != null) {
      context.read<FilamentizeData>().filamentizeOne!.setNotifyValue(true);
    }
    if (context.watch<FilamentizeData>().filamentizeTwo != null) {
      context.read<FilamentizeData>().filamentizeTwo!.setNotifyValue(true);
    }
    super.didChangeDependencies();
  }

  // current user
  final currentUser = FirebaseAuth.instance.currentUser;

  var moldingModel = {"temp": "--", "type": "--"};

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            context.read<FilamentizeData>().filamentizeThree!.onValueReceived,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final decodedFilamentizeThreeNotifyData =
                utf8.decode(snapshot.data!).split("/");
            spoolMotor = double.parse(decodedFilamentizeThreeNotifyData[0]);
            extruder = double.parse(decodedFilamentizeThreeNotifyData[1]);
            stepper = double.parse(decodedFilamentizeThreeNotifyData[2]);
            color = decodedFilamentizeThreeNotifyData[4];
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Image.asset("images/logo.png", width: 39, height: 39),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (context.read<FilamentizeData>().filamentizeOne !=
                            null) {
                          context
                              .read<FilamentizeData>()
                              .filamentizeDevice!
                              .disconnect();
                        }
                      },
                      icon: const Icon(Icons.minimize))
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
                  child: Column(
                    children: [
                      // filamentize image + status + selected color
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: ColorsAsset.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // filamentize image
                                Image.asset("images/filamentizeMachine.png",
                                    width: 96, height: 106),

                                const SizedBox(width: 20),

                                // divider
                                Container(
                                    width: 2,
                                    height: 60,
                                    color: ColorsAsset.littleGrey),

                                const SizedBox(width: 20),

                                // status
                                widget.filamentizeStatus == "On"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // status color + on/off text
                                          Row(
                                            children: [
                                              // status color
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                    color: ColorsAsset.green,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2))),
                                              ),

                                              const SizedBox(width: 2),

                                              // on/off text
                                              Text(
                                                  AppLocale.deviceOn
                                                      .getString(context),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),

                                          // mode
                                          Text("Molding Mode",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorsAsset.littleGrey))
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // status color + on/off text
                                          Row(
                                            children: [
                                              // status color
                                              Container(
                                                width: 20,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                    color: ColorsAsset.red,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2))),
                                              ),

                                              const SizedBox(width: 2),

                                              // on/off text
                                              Text(
                                                  AppLocale.deviceOff
                                                      .getString(context),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),

                                          // mode
                                          Text("Molding Mode",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorsAsset.littleGrey))
                                        ],
                                      )
                              ],
                            ),

                            // selected color
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          "${AppLocale.selectedColor.getString(context)} : ",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black)),
                                  TextSpan(
                                      text: selectedColor,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.yellow[800])),
                                ])),
                              ],
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // stats
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 20),
                        decoration: const BoxDecoration(
                            color: ColorsAsset.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // stats
                            StreamBuilder(
                                stream: context
                                    .read<FilamentizeData>()
                                    .filamentizeOne!
                                    .onValueReceived,
                                builder: (context, snapshot1) {
                                  return StreamBuilder(
                                      stream: context
                                          .read<FilamentizeData>()
                                          .filamentizeTwo!
                                          .onValueReceived,
                                      builder: (context, snapshot2) {
                                        if (snapshot2.hasData) {
                                          final decodedFilamentizeOneNotifyData =
                                              utf8
                                                  .decode(snapshot1.data!)
                                                  .split("/");
                                          temp01 = int.parse(
                                              decodedFilamentizeOneNotifyData[
                                                  0]);
                                          temp02 = int.parse(
                                              decodedFilamentizeOneNotifyData[
                                                  1]);
                                          setTemp01 = int.parse(
                                              decodedFilamentizeOneNotifyData[
                                                  2]);
                                          setTemp02 = int.parse(
                                              decodedFilamentizeOneNotifyData[
                                                  3]);
                                          final decodedFilamentizeTwoNotifyData =
                                              utf8
                                                  .decode(snapshot.data!)
                                                  .split("/");
                                          setFanOne = double.parse(
                                              decodedFilamentizeTwoNotifyData[
                                                  2]);
                                          setFanTwo = double.parse(
                                              decodedFilamentizeTwoNotifyData[
                                                  3]);
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // icon button
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              ColorsAsset.white,
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                                width: double
                                                                    .infinity,
                                                                height: 522,
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        25),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    const SizedBox(
                                                                        height:
                                                                            30),
                                                                    // stats header
                                                                    Text(
                                                                        AppLocale
                                                                            .stats
                                                                            .getString(
                                                                                context),
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                24,
                                                                            fontWeight:
                                                                                FontWeight.w600)),

                                                                    const SizedBox(
                                                                        height:
                                                                            34),

                                                                    // temp
                                                                    SizedBox(
                                                                      width:
                                                                          350,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          // button icon
                                                                          Column(
                                                                            children: [
                                                                              // icon button
                                                                              const MyIconButton(rectSize: 51, iconSize: 35, icon: Icons.thermostat),

                                                                              // temp
                                                                              Text(AppLocale.temperature.getString(context), style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),

                                                                          // temp 2
                                                                          Column(
                                                                            children: [
                                                                              const SizedBox(height: 7),
                                                                              // temp
                                                                              MyTemp(rlTemp: temp02, setTemp: setTemp02),

                                                                              const SizedBox(height: 10),

                                                                              // text
                                                                              Text(AppLocale.temperature.getString(context), style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    const SizedBox(
                                                                        height:
                                                                            35),

                                                                    // cooling fans
                                                                    SizedBox(
                                                                      width:
                                                                          350,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          // button icon
                                                                          Column(
                                                                            children: [
                                                                              // icon button
                                                                              const MyIconButton(rectSize: 51, iconSize: 35, icon: Icons.wind_power),

                                                                              // text
                                                                              Text(
                                                                                AppLocale.coolingFan.getString(context),
                                                                                style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600),
                                                                              )
                                                                            ],
                                                                          ),

                                                                          const SizedBox(
                                                                              width: 15),

                                                                          // fan 1
                                                                          MySlider(
                                                                              sliderValue: setFanOne,
                                                                              isRotate: false,
                                                                              sizedBoxWidth: 100,
                                                                              setFanSpeed: () {
                                                                                context.read<FilamentizeData>().coolingFan01!.write(utf8.encode(setFanOne.toString()));
                                                                              }),

                                                                          const SizedBox(
                                                                              width: 10),

                                                                          // fan 2
                                                                          MySlider(
                                                                              sliderValue: setFanTwo,
                                                                              isRotate: false,
                                                                              sizedBoxWidth: 100,
                                                                              setFanSpeed: () {
                                                                                context.read<FilamentizeData>().coolingFan02!.write(utf8.encode(setFanTwo.toString()));
                                                                              })
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    const SizedBox(
                                                                        height:
                                                                            35),

                                                                    // speed
                                                                    SizedBox(
                                                                      width:
                                                                          350,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceAround,
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 1),
                                                                          // icon button
                                                                          Column(
                                                                            children: [
                                                                              // icon button
                                                                              const MyIconButton(rectSize: 51, iconSize: 35, icon: Icons.speed),

                                                                              // text
                                                                              Text(
                                                                                AppLocale.speed.getString(context),
                                                                                style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w600),
                                                                              )
                                                                            ],
                                                                          ),

                                                                          // extruder
                                                                          Column(
                                                                            children: [
                                                                              // spool motor percent
                                                                              Text("${extruder.round()}%", style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold)),

                                                                              // extruder text
                                                                              Text(AppLocale.extruder.getString(context), style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),

                                                                          // stepper
                                                                          Column(
                                                                            children: [
                                                                              // spool motor percent
                                                                              Text("${stepper.round()}%", style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold)),

                                                                              // stepper text
                                                                              Text("Base", style: GoogleFonts.montserrat(fontSize: 11, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ));
                                                          });
                                                    },
                                                    child: const MyIconButton(
                                                      icon: Icons
                                                          .perm_data_setting,
                                                      iconSize: 30,
                                                      rectSize: 44,
                                                    ),
                                                  ),
                                                  Text(
                                                      AppLocale.stats
                                                          .getString(context),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600))
                                                ],
                                              ),

                                              const SizedBox(width: 15),

                                              // temp
                                              SizedBox(
                                                width: 80,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // rl temp
                                                    Text("$temp02°C",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    // temp
                                                    Text(
                                                        AppLocale.temperature
                                                            .getString(context),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(width: 4),

                                              // fan
                                              SizedBox(
                                                width: 70,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // fan percent
                                                    Text(
                                                        "${setFanOne.round()}%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    // fan
                                                    Text(
                                                        AppLocale.fan
                                                            .getString(context),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),
                                              ),

                                              // speed
                                              SizedBox(
                                                width: 70,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // speed detail
                                                    Text("Med",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    // speed
                                                    Text(
                                                        AppLocale.speed
                                                            .getString(context),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return const Center(
                                            child: CircularProgressIndicator(
                                                color: ColorsAsset.green));
                                      });
                                }),

                            const SizedBox(height: 32),

                            // speed
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // icon button
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            backgroundColor: ColorsAsset.white,
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                width: double.infinity,
                                                height: 463,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25),
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 30),
                                                    // molding header
                                                    Text(
                                                        AppLocale.molding
                                                            .getString(context),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),

                                                    const SizedBox(height: 36),

                                                    // my molding
                                                    Expanded(
                                                      child: StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Users")
                                                              .doc(currentUser!
                                                                  .email)
                                                              .collection(
                                                                  "myMolding")
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return ListView
                                                                  .builder(
                                                                      itemCount: snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        final myMolding = snapshot
                                                                            .data!
                                                                            .docs[index];
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              moldingModel["temp"] = myMolding["temp"];
                                                                              moldingModel["type"] = myMolding["type"];
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              MyMolding(
                                                                            modelName:
                                                                                myMolding["name"],
                                                                            plastictype:
                                                                                myMolding["type"],
                                                                            plasticUsed:
                                                                                myMolding["used"],
                                                                            requiredTemp:
                                                                                myMolding["temp"],
                                                                          ),
                                                                        );
                                                                      });
                                                            } else if (snapshot
                                                                .hasError) {
                                                              Text(
                                                                  "error: ${snapshot.error}",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          24,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600));
                                                            }
                                                            return const Center(
                                                                child: CircularProgressIndicator(
                                                                    color: ColorsAsset
                                                                        .green));
                                                          }),
                                                    ),

                                                    const SizedBox(height: 15),

                                                    GestureDetector(
                                                      onTap: () {
                                                        final modelNameController =
                                                            TextEditingController();
                                                        final requiredTempController =
                                                            TextEditingController();
                                                        final plasticUsageController =
                                                            TextEditingController();
                                                        var plasticType = "PET";
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title: Text(
                                                                          "${AppLocale.add.getString(context)} ${AppLocale.modelName.getString(context)}",
                                                                          style:
                                                                              GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                      content: StatefulBuilder(builder:
                                                                          (context,
                                                                              setState) {
                                                                        return SingleChildScrollView(
                                                                          child:
                                                                              SizedBox(
                                                                            height:
                                                                                250,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                // model name
                                                                                TextField(
                                                                                  cursorColor: ColorsAsset.green,
                                                                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey),
                                                                                  controller: modelNameController,
                                                                                  decoration: InputDecoration(hintText: AppLocale.modelName.getString(context), hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey)),
                                                                                ),

                                                                                const SizedBox(height: 15),

                                                                                // required temp
                                                                                TextField(
                                                                                  cursorColor: ColorsAsset.green,
                                                                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey),
                                                                                  controller: requiredTempController,
                                                                                  decoration: InputDecoration(hintText: AppLocale.requiredTemp.getString(context), hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey)),
                                                                                ),

                                                                                const SizedBox(height: 15),

                                                                                // plastic usage
                                                                                TextField(
                                                                                  cursorColor: ColorsAsset.green,
                                                                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey),
                                                                                  controller: plasticUsageController,
                                                                                  decoration: InputDecoration(hintText: AppLocale.plasticUsage.getString(context), hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey)),
                                                                                ),

                                                                                const SizedBox(height: 20),

                                                                                // plastic type
                                                                                Row(
                                                                                  children: [
                                                                                    // plastic type text
                                                                                    Text("${AppLocale.plasticType.getString(context)} : ", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18, color: ColorsAsset.littleGrey)),
                                                                                    // drop down menu
                                                                                    DropdownButton(
                                                                                        value: plasticType,
                                                                                        items: [
                                                                                          DropdownMenuItem(value: "PET", child: Text("PET", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))),
                                                                                          DropdownMenuItem(value: "PLA", child: Text("PLA", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))),
                                                                                        ],
                                                                                        onChanged: (String? newValue) {
                                                                                          setState(() {
                                                                                            plasticType = newValue!;
                                                                                          });
                                                                                        }),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: Text(AppLocale.cancel.getString(context),
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontWeight: FontWeight.w600,
                                                                                ))),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () async {
                                                                              showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(color: ColorsAsset.green)));
                                                                              await FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).collection("myMolding").add({
                                                                                "name": modelNameController.text,
                                                                                "temp": requiredTempController.text,
                                                                                "type": plasticType,
                                                                                "used": plasticUsageController.text
                                                                              });
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(AppLocale.ok.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.green))),
                                                                      ],
                                                                    ));
                                                      },
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            color: ColorsAsset
                                                                .grey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 30),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              // add icon
                                                              const Icon(
                                                                  Icons.add,
                                                                  size: 34),

                                                              // add
                                                              Text(
                                                                AppLocale.add
                                                                    .getString(
                                                                        context),
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15)
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      child: const MyIconButton(
                                          rectSize: 44,
                                          iconSize: 30,
                                          icon: Icons.format_shapes),
                                    ),
                                    Text(AppLocale.molding.getString(context),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),

                                const SizedBox(width: 20),

                                // molding + rl mold temp
                                Row(
                                  children: [
                                    // mold temp + rl mold temp
                                    Column(
                                      children: [
                                        // rl mold temp
                                        Text("${moldingModel["temp"]}°C",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),

                                        // mold temp
                                        Text(
                                          AppLocale.moldTemp.getString(context),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),

                                    const SizedBox(width: 30),

                                    // plastic type
                                    Column(
                                      children: [
                                        // type
                                        Text("${moldingModel["type"]}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),

                                        // type
                                        Text(
                                          AppLocale.type.getString(context),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 30),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // start/stop + misc button
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            color: ColorsAsset.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // start/stop button
                            GestureDetector(
                                onTap: widget.toggleStatus,
                                child: widget.filamentizeStatus == "On"
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 68, vertical: 9),
                                        decoration: const BoxDecoration(
                                            color: ColorsAsset.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // stop icon
                                            const Icon(
                                              Icons.stop_outlined,
                                              color: ColorsAsset.white,
                                              size: 28,
                                            ),

                                            // stop text
                                            Text(
                                                AppLocale.stop
                                                    .getString(context),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorsAsset.white))
                                          ],
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 68, vertical: 9),
                                        decoration: const BoxDecoration(
                                            color: ColorsAsset.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // stop icon
                                            const Icon(
                                              Icons.play_arrow_outlined,
                                              color: ColorsAsset.white,
                                              size: 28,
                                            ),

                                            // stop text
                                            Text(
                                                AppLocale.start
                                                    .getString(context),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorsAsset.white))
                                          ],
                                        ),
                                      )),

                            const SizedBox(width: 8),

                            // misc button
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                color: ColorsAsset.littleGrey,
                              ),
                              child: PopupMenuButton(
                                color: ColorsAsset.littleGrey,
                                icon: const Icon(Icons.more_horiz,
                                    size: 30, color: ColorsAsset.white),
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "switch color",
                                    child: Text(
                                      AppLocale.selectedColor
                                          .getString(context),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: ColorsAsset.white),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "Switch Mode",
                                    child: Text(
                                      AppLocale.switchMode.getString(context),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: ColorsAsset.white),
                                    ),
                                  )
                                ],
                                onSelected: (newValue) {
                                  if (newValue == "Switch Mode") {
                                    widget.toggleFilamentize!();
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return const Center(
              child: CircularProgressIndicator(color: ColorsAsset.green));
        });
  }
}
