import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_iconbutton.dart';
import 'package:filamentize2/components/my_slider.dart';
import 'package:filamentize2/components/my_temp.dart';
import 'package:filamentize2/pages/can_filamentize_page.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageConnected extends StatefulWidget {
  final Function()? toggleFilamentize;
  final Function()? toggleStatus;
  final String filamentizeStatus;
  const HomePageConnected(
      {super.key,
      required this.toggleFilamentize,
      required this.toggleStatus,
      required this.filamentizeStatus});

  @override
  State<HomePageConnected> createState() => _HomePageConnectedState();
}

class _HomePageConnectedState extends State<HomePageConnected> {
  int temp01 = 0;
  int temp02 = 0;
  int setTemp01 = 0;
  int setTemp02 = 0;
  double setFanOne = 0;
  double setFanTwo = 0;
  double spoolMotor = 0;
  double extruder = 0;
  double stepper = 0;
  double vibrator = 0;
  String color = "";
  var selectedColor = "";
  String weight = "";
  String grindingState = "";
  var Options;

  bool isControl = true;

  // text editing controllers
  var setTemp01Controller = TextEditingController();
  var setTemp02Controller = TextEditingController();

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
    super.didChangeDependencies();
    if (context.watch<FilamentizeData>().filamentizeThree != null) {
      context.read<FilamentizeData>().filamentizeThree!.setNotifyValue(true);
    }
    if (context.watch<FilamentizeData>().otherNotify != null) {
      context.read<FilamentizeData>().otherNotify!.setNotifyValue(true);
    }
    if (context.watch<FilamentizeData>().filamentizeOne != null) {
      context.read<FilamentizeData>().filamentizeOne!.setNotifyValue(true);
    }
    if (context.watch<FilamentizeData>().filamentizeTwo != null) {
      context.read<FilamentizeData>().filamentizeTwo!.setNotifyValue(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    if (context.watch<FilamentizeData>().filamentizeDevice != null) {
      return StreamBuilder(
          stream:
              context.read<FilamentizeData>().filamentizeThree?.onValueReceived,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final decodedFilamentizeThreeNotifyData =
                  utf8.decode(snapshot.data!).split("/");
              spoolMotor = double.parse(decodedFilamentizeThreeNotifyData[0]);
              extruder = double.parse(decodedFilamentizeThreeNotifyData[1]);
              stepper = double.parse(decodedFilamentizeThreeNotifyData[2]);
              vibrator = double.parse(decodedFilamentizeThreeNotifyData[3]);
              color = decodedFilamentizeThreeNotifyData[4];
              return StreamBuilder(
                  stream: context
                      .read<FilamentizeData>()
                      .otherNotify
                      ?.onValueReceived,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final decodedOtherNotifyData =
                          utf8.decode(snapshot.data!).split("/");
                      weight = decodedOtherNotifyData[0];
                      grindingState = decodedOtherNotifyData[1];
                      return Scaffold(
                        appBar: AppBar(
                          centerTitle: true,
                          title: Image.asset("images/logo.png",
                              width: 39, height: 39),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  if (context
                                          .read<FilamentizeData>()
                                          .filamentizeOne !=
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
                            padding: const EdgeInsets.only(
                                left: 23, right: 23, top: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isControl = true;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h),
                                          decoration: BoxDecoration(
                                              color: isControl
                                                  ? ColorsAsset.green
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text("Control",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: isControl
                                                      ? Colors.white
                                                      : Colors.black)),
                                        ),
                                      ),
                                      SizedBox(width: 35.w),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isControl = false;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.h),
                                          decoration: BoxDecoration(
                                              color: isControl
                                                  ? Colors.transparent
                                                  : ColorsAsset.green,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text("Interact",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: isControl
                                                      ? Colors.black
                                                      : Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),

                                  SizedBox(height: 15.h),

                                  // filamentize image + status + selected color
                                  if (isControl) ...[
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                          color: ColorsAsset.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // filamentize image
                                              Image.asset(
                                                  "images/filamentizeMachine.png",
                                                  width: 96,
                                                  height: 106),

                                              const SizedBox(width: 20),

                                              // divider
                                              Container(
                                                  width: 2,
                                                  height: 60,
                                                  color:
                                                      ColorsAsset.littleGrey),

                                              const SizedBox(width: 20),

                                              // status
                                              widget.filamentizeStatus == "On"
                                                  ? Column(
                                                      children: [
                                                        // status color + on/off text
                                                        Row(
                                                          children: [
                                                            // status color
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: const BoxDecoration(
                                                                  color:
                                                                      ColorsAsset
                                                                          .green,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              2))),
                                                            ),

                                                            const SizedBox(
                                                                width: 2),

                                                            // on/off text
                                                            Text(
                                                                AppLocale
                                                                    .deviceOn
                                                                    .getString(
                                                                        context),
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ),

                                                        // mode
                                                        Text("Filamentize Mode",
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: ColorsAsset
                                                                    .littleGrey))
                                                      ],
                                                    )
                                                  : Column(
                                                      children: [
                                                        // status color + on/off text
                                                        Row(
                                                          children: [
                                                            // status color
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: const BoxDecoration(
                                                                  color:
                                                                      ColorsAsset
                                                                          .red,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              2))),
                                                            ),

                                                            const SizedBox(
                                                                width: 2),

                                                            // on/off text
                                                            Text(
                                                                AppLocale
                                                                    .deviceOff
                                                                    .getString(
                                                                        context),
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ),

                                                        // mode
                                                        Text("Filamentize Mode",
                                                            style: GoogleFonts.montserrat(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: ColorsAsset
                                                                    .littleGrey))
                                                      ],
                                                    )
                                            ],
                                          ),

                                          // selected color
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        "${AppLocale.selectedColor.getString(context)} : ",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black)),
                                                TextSpan(
                                                    text: selectedColor,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black)),
                                              ])),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // stats
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 20),
                                      decoration: const BoxDecoration(
                                          color: ColorsAsset.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // temp
                                          StreamBuilder(
                                              stream: context
                                                  .read<FilamentizeData>()
                                                  .filamentizeOne!
                                                  .onValueReceived,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final decodedFilamentizeOneNotifyData =
                                                      utf8
                                                          .decode(
                                                              snapshot.data!)
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
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // icon button
                                                      Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  backgroundColor:
                                                                      ColorsAsset
                                                                          .white,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            463,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            const SizedBox(height: 30),
                                                                            // temperature header
                                                                            Text(AppLocale.temperature.getString(context),
                                                                                style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600)),

                                                                            const SizedBox(height: 36),

                                                                            // temp 1 set
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                // my icon button
                                                                                Column(
                                                                                  children: [
                                                                                    // icon button
                                                                                    const MyIconButton(rectSize: 59, iconSize: 40, icon: Icons.thermostat),

                                                                                    // temperature text
                                                                                    Text(AppLocale.temperature.getString(context), style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600))
                                                                                  ],
                                                                                ),

                                                                                const SizedBox(width: 50),

                                                                                // set temp
                                                                                Column(
                                                                                  children: [
                                                                                    const SizedBox(height: 10),
                                                                                    // real time temp
                                                                                    MyTemp(rlTemp: temp02, setTemp: setTemp02),

                                                                                    // set temp button
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(top: 10),
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          showDialog(
                                                                                              context: context,
                                                                                              builder: (context) => AlertDialog(
                                                                                                    title: Text(AppLocale.setTemp.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                                                    content: TextField(
                                                                                                      controller: setTemp02Controller,
                                                                                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                                                                                      decoration: InputDecoration(hintText: setTemp02.toString(), hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey)),
                                                                                                    ),
                                                                                                    actions: [
                                                                                                      TextButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          child: Text(AppLocale.cancel.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))),
                                                                                                      TextButton(
                                                                                                          onPressed: () async {
                                                                                                            var temp = int.parse(setTemp02Controller.text);
                                                                                                            await context.read<FilamentizeData>().temp02!.write(utf8.encode(temp.toString()));
                                                                                                            Navigator.pop(context);
                                                                                                            Navigator.pop(context);
                                                                                                            setTemp02Controller.clear();
                                                                                                          },
                                                                                                          child: Text(AppLocale.ok.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.green)))
                                                                                                    ],
                                                                                                  ));
                                                                                        },
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                                                                                          decoration: const BoxDecoration(color: ColorsAsset.littleGrey, borderRadius: BorderRadius.all(Radius.circular(12))),
                                                                                          child: Row(
                                                                                            children: [
                                                                                              // icon
                                                                                              const Icon(Icons.settings_outlined),

                                                                                              // set text
                                                                                              Text(AppLocale.set.getString(context), style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600))
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ));
                                                                  });
                                                            },
                                                            child:
                                                                const MyIconButton(
                                                              icon: Icons
                                                                  .device_thermostat,
                                                              iconSize: 30,
                                                              rectSize: 44,
                                                            ),
                                                          ),
                                                          Text(
                                                              AppLocale
                                                                  .temperature
                                                                  .getString(
                                                                      context),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                        ],
                                                      ),

                                                      // temp 1
                                                      SizedBox(
                                                        width: 130,
                                                        height: 55,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // temp val
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20),
                                                              child: MyTemp(
                                                                rlTemp: temp02,
                                                                setTemp:
                                                                    setTemp02,
                                                              ),
                                                            ),

                                                            const SizedBox(
                                                                height: 6),

                                                            // temperature 1
                                                            Text(
                                                              AppLocale
                                                                  .temperature
                                                                  .getString(
                                                                      context),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      "error: ${snapshot.error}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600));
                                                }
                                                return const Center(
                                                    child:
                                                        LinearProgressIndicator(
                                                            color: ColorsAsset
                                                                .green));
                                              }),

                                          const SizedBox(height: 32),

                                          // cooling fans
                                          StreamBuilder(
                                              stream: context
                                                  .read<FilamentizeData>()
                                                  .filamentizeTwo!
                                                  .onValueReceived,
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  final decodedFilamentizeTwoNotifyData =
                                                      utf8
                                                          .decode(
                                                              snapshot.data!)
                                                          .split("/");
                                                  setFanOne = double.parse(
                                                      decodedFilamentizeTwoNotifyData[
                                                          2]);
                                                  setFanTwo = double.parse(
                                                      decodedFilamentizeTwoNotifyData[
                                                          3]);
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      // icon button
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 3),
                                                        child: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                var setFanOneCopy =
                                                                    setFanOne;
                                                                var setFanTwoCopy =
                                                                    setFanTwo;
                                                                showModalBottomSheet(
                                                                    backgroundColor:
                                                                        ColorsAsset
                                                                            .white,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return StatefulBuilder(builder:
                                                                          (context,
                                                                              setState) {
                                                                        return SizedBox(
                                                                          height:
                                                                              350,
                                                                          width:
                                                                              double.infinity,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const SizedBox(height: 30),
                                                                              // cooling fans
                                                                              Text(AppLocale.coolingFan.getString(context), style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600)),
                                                                              const SizedBox(height: 38),

                                                                              // cooling fans stat
                                                                              SliderTheme(
                                                                                data: SliderThemeData(trackHeight: 50, trackShape: const RectangularSliderTrackShape(), thumbShape: SliderComponentShape.noOverlay, overlayShape: SliderComponentShape.noOverlay, activeTrackColor: ColorsAsset.green, inactiveTrackColor: ColorsAsset.littleGrey, valueIndicatorShape: SliderComponentShape.noOverlay, activeTickMarkColor: Colors.transparent, inactiveTickMarkColor: Colors.transparent),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    // icon button 1
                                                                                    Column(
                                                                                      children: [
                                                                                        const MyIconButton(rectSize: 50, iconSize: 35, icon: Icons.wind_power),
                                                                                        Text("${AppLocale.fan.getString(context)} 1", style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                                      ],
                                                                                    ),

                                                                                    const SizedBox(width: 5),

                                                                                    // slider 1
                                                                                    SizedBox(
                                                                                      width: 60,
                                                                                      child: Stack(alignment: Alignment.center, children: [
                                                                                        RotatedBox(
                                                                                          quarterTurns: 3,
                                                                                          child: Slider(
                                                                                            value: setFanOneCopy,
                                                                                            divisions: 10,
                                                                                            min: 0,
                                                                                            max: 100,
                                                                                            onChanged: (double newValue) {
                                                                                              setState(() {
                                                                                                setFanOneCopy = newValue;
                                                                                              });
                                                                                              context.read<FilamentizeData>().coolingFan01!.write(utf8.encode(setFanOneCopy.toString()));
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                        Text("${setFanOneCopy.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                                      ]),
                                                                                    ),

                                                                                    // slider 2
                                                                                    SizedBox(
                                                                                      width: 60,
                                                                                      child: Stack(alignment: Alignment.center, children: [
                                                                                        RotatedBox(
                                                                                          quarterTurns: 3,
                                                                                          child: Slider(
                                                                                            value: setFanTwoCopy,
                                                                                            divisions: 10,
                                                                                            min: 0,
                                                                                            max: 100,
                                                                                            onChanged: (double newValue) {
                                                                                              setState(() {
                                                                                                setFanTwoCopy = newValue;
                                                                                              });
                                                                                              context.read<FilamentizeData>().coolingFan02!.write(utf8.encode(setFanTwoCopy.toString()));
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                        Text("${setFanTwoCopy.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                                      ]),
                                                                                    ),

                                                                                    const SizedBox(width: 5),

                                                                                    // icon button 2
                                                                                    Column(
                                                                                      children: [
                                                                                        const MyIconButton(rectSize: 50, iconSize: 35, icon: Icons.wind_power),
                                                                                        Text("${AppLocale.fan.getString(context)} 2", style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                                      ],
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                    });
                                                              },
                                                              child: const MyIconButton(
                                                                  rectSize: 44,
                                                                  iconSize: 30,
                                                                  icon: Icons
                                                                      .wind_power),
                                                            ),
                                                            Text(
                                                                AppLocale
                                                                    .coolingFan
                                                                    .getString(
                                                                        context),
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ),
                                                      ),

                                                      SizedBox(
                                                        width: 115,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 5),
                                                            // fan slider 1
                                                            MySlider(
                                                              sliderValue:
                                                                  setFanOne,
                                                              isRotate: false,
                                                              setFanSpeed: null,
                                                            ),

                                                            const SizedBox(
                                                                height: 5),

                                                            // fan 1 text
                                                            Text(
                                                                "${AppLocale.fan.getString(context)} 1",
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ),
                                                      ),

                                                      // fan slider 2
                                                      SizedBox(
                                                        width: 115,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                                height: 5),
                                                            // fan slider 2
                                                            MySlider(
                                                                sliderValue:
                                                                    setFanTwo,
                                                                isRotate: false,
                                                                setFanSpeed:
                                                                    null),

                                                            const SizedBox(
                                                                height: 5),

                                                            // fan 2 text
                                                            Text(
                                                                "${AppLocale.fan.getString(context)} 2",
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      "error: ${snapshot.error}",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600));
                                                }
                                                return const Center(
                                                    child:
                                                        LinearProgressIndicator(
                                                            color: ColorsAsset
                                                                .green));
                                              }),

                                          const SizedBox(height: 32),

                                          // speed
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              // icon button
                                              Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          context: context,
                                                          builder: (context) {
                                                            return SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              height: 550,
                                                              child:
                                                                  SliderTheme(
                                                                data: SliderThemeData(
                                                                    trackHeight:
                                                                        50,
                                                                    trackShape:
                                                                        const RectangularSliderTrackShape(),
                                                                    thumbShape:
                                                                        SliderComponentShape
                                                                            .noOverlay,
                                                                    overlayShape:
                                                                        SliderComponentShape
                                                                            .noOverlay,
                                                                    activeTrackColor:
                                                                        ColorsAsset
                                                                            .green,
                                                                    inactiveTrackColor:
                                                                        ColorsAsset
                                                                            .littleGrey,
                                                                    valueIndicatorShape:
                                                                        SliderComponentShape
                                                                            .noOverlay,
                                                                    activeTickMarkColor:
                                                                        Colors
                                                                            .transparent,
                                                                    inactiveTickMarkColor:
                                                                        Colors
                                                                            .transparent),
                                                                child: StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                          height:
                                                                              30),
                                                                      // Speed Mode
                                                                      Text(
                                                                          AppLocale.speedMode.getString(
                                                                              context),
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 24,
                                                                              fontWeight: FontWeight.w600)),

                                                                      const SizedBox(
                                                                          height:
                                                                              15),

                                                                      // spool motor
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          // icon button
                                                                          Column(
                                                                            children: [
                                                                              // icon
                                                                              const MyIconButton(rectSize: 50, iconSize: 36, icon: Icons.motion_photos_on_outlined),
                                                                              // name
                                                                              Text(AppLocale.spoolMotor.getString(context), style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),

                                                                          const SizedBox(
                                                                              width: 20),

                                                                          // slider
                                                                          SizedBox(
                                                                            width:
                                                                                200,
                                                                            child:
                                                                                Stack(alignment: Alignment.center, children: [
                                                                              Slider(
                                                                                value: spoolMotor,
                                                                                min: 0,
                                                                                max: 100,
                                                                                divisions: 10,
                                                                                onChanged: (double newValue) {
                                                                                  setState(() {
                                                                                    spoolMotor = newValue;
                                                                                  });
                                                                                  context.read<FilamentizeData>().spoolMotor!.write(utf8.encode(spoolMotor.toString()));
                                                                                },
                                                                              ),
                                                                              Text("${spoolMotor.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                            ]),
                                                                          )
                                                                        ],
                                                                      ),

                                                                      const SizedBox(
                                                                          height:
                                                                              15),

                                                                      // extruder
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 13),
                                                                          // icon button
                                                                          Column(
                                                                            children: [
                                                                              // icon
                                                                              const MyIconButton(rectSize: 50, iconSize: 36, icon: Icons.present_to_all_sharp),
                                                                              // name
                                                                              Text(AppLocale.extruder.getString(context), style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),

                                                                          const SizedBox(
                                                                              width: 32),

                                                                          // slider
                                                                          SizedBox(
                                                                            width:
                                                                                200,
                                                                            child:
                                                                                Stack(alignment: Alignment.center, children: [
                                                                              Slider(
                                                                                value: extruder,
                                                                                min: 0,
                                                                                max: 100,
                                                                                divisions: 10,
                                                                                onChanged: (double newValue) {
                                                                                  setState(() {
                                                                                    extruder = newValue;
                                                                                  });
                                                                                  context.read<FilamentizeData>().extruder!.write(utf8.encode(extruder.toString()));
                                                                                },
                                                                              ),
                                                                              Text("${extruder.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                            ]),
                                                                          )
                                                                        ],
                                                                      ),

                                                                      const SizedBox(
                                                                          height:
                                                                              15),

                                                                      // vibrator
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 20),
                                                                          // icon button
                                                                          Column(
                                                                            children: [
                                                                              // icon
                                                                              const MyIconButton(rectSize: 50, iconSize: 36, icon: Icons.cyclone),
                                                                              // name
                                                                              Text(AppLocale.stepper.getString(context), style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),

                                                                          // slider
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 35),
                                                                            child:
                                                                                SizedBox(
                                                                              width: 200,
                                                                              child: Stack(alignment: Alignment.center, children: [
                                                                                Slider(
                                                                                  value: stepper,
                                                                                  min: 0,
                                                                                  max: 100,
                                                                                  divisions: 10,
                                                                                  onChanged: (double newValue) {
                                                                                    setState(() {
                                                                                      stepper = newValue;
                                                                                    });
                                                                                    context.read<FilamentizeData>().stepper!.write(utf8.encode(stepper.toString()));
                                                                                  },
                                                                                ),
                                                                                Text("${stepper.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                              ]),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 5)
                                                                        ],
                                                                      ),

                                                                      const SizedBox(
                                                                          height:
                                                                              20),

                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          const SizedBox(
                                                                              width: 20),
                                                                          // icon button
                                                                          Column(
                                                                            children: [
                                                                              // icon
                                                                              const MyIconButton(rectSize: 50, iconSize: 36, icon: Icons.vibration_outlined),
                                                                              // name
                                                                              Text(AppLocale.vibrator.getString(context), style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                            ],
                                                                          ),

                                                                          // slider
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 35),
                                                                            child:
                                                                                SizedBox(
                                                                              width: 200,
                                                                              child: Stack(alignment: Alignment.center, children: [
                                                                                Slider(
                                                                                  value: vibrator,
                                                                                  min: 0,
                                                                                  max: 100,
                                                                                  divisions: 10,
                                                                                  onChanged: (double newValue) {
                                                                                    setState(() {
                                                                                      vibrator = newValue;
                                                                                    });
                                                                                    context.read<FilamentizeData>().vibrator!.write(utf8.encode(vibrator.toString()));
                                                                                  },
                                                                                ),
                                                                                Text("${vibrator.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                              ]),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 5)
                                                                        ],
                                                                      )
                                                                    ],
                                                                  );
                                                                }),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: const MyIconButton(
                                                        rectSize: 44,
                                                        iconSize: 30,
                                                        icon: Icons.speed),
                                                  ),
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

                                              // spool motor
                                              SizedBox(
                                                width: 65,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // percent
                                                    Text(
                                                        "${spoolMotor.round()}%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),

                                                    // spool motor
                                                    Text(
                                                        AppLocale.spoolMotor
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

                                              // extruder
                                              SizedBox(
                                                width: 65,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // percent
                                                    Text("${extruder.round()}%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),

                                                    // extruder
                                                    Text(
                                                        AppLocale.extruder
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

                                              // stepper
                                              SizedBox(
                                                width: 65,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // percent
                                                    Text("${stepper.round()}%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),

                                                    // stepper
                                                    Text(
                                                        AppLocale.stepper
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
                                          )
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // start/stop + misc button
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                          color: ColorsAsset.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // start/stop button
                                          GestureDetector(
                                              onTap: widget.toggleStatus,
                                              child: widget.filamentizeStatus ==
                                                      "On"
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 68,
                                                          vertical: 9),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              ColorsAsset.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          // stop icon
                                                          const Icon(
                                                            Icons.stop_outlined,
                                                            color: ColorsAsset
                                                                .white,
                                                            size: 28,
                                                          ),

                                                          // stop text
                                                          Text(
                                                              AppLocale.stop
                                                                  .getString(
                                                                      context),
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      ColorsAsset
                                                                          .white))
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 68,
                                                          vertical: 9),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              ColorsAsset.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          6))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          // stop icon
                                                          const Icon(
                                                            Icons
                                                                .play_arrow_outlined,
                                                            color: ColorsAsset
                                                                .white,
                                                            size: 28,
                                                          ),

                                                          // start text
                                                          Text(
                                                              AppLocale.start
                                                                  .getString(
                                                                      context),
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color:
                                                                      ColorsAsset
                                                                          .white))
                                                        ],
                                                      ),
                                                    )),

                                          const SizedBox(width: 8),

                                          // misc button
                                          Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              color: ColorsAsset.littleGrey,
                                            ),
                                            child: PopupMenuButton(
                                              color: ColorsAsset.littleGrey,
                                              icon: const Icon(Icons.more_horiz,
                                                  size: 30,
                                                  color: ColorsAsset.white),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: "switch color",
                                                  child: Text(
                                                    AppLocale.selectedColor
                                                        .getString(context),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorsAsset
                                                                .white),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: "Switch Mode",
                                                  child: Text(
                                                    AppLocale.switchMode
                                                        .getString(context),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorsAsset
                                                                .white),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: "Plastic Checking",
                                                  child: Text(
                                                    AppLocale.plasticChecking
                                                        .getString(context),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorsAsset
                                                                .white),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: "Reset Spool",
                                                  child: Text(
                                                    AppLocale.resetSpool
                                                        .getString(context),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorsAsset
                                                                .white),
                                                  ),
                                                ),
                                              ],
                                              onSelected: (newValue) async {
                                                if (newValue ==
                                                    "Plastic Checking") {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const CanFilamentizePage()));
                                                }
                                                if (newValue ==
                                                    "Start Grinding") {
                                                  if (grindingState == "0") {
                                                    await context
                                                        .read<FilamentizeData>()
                                                        .otherWrite!
                                                        .write(
                                                            utf8.encode("1"));
                                                  } else {
                                                    await context
                                                        .read<FilamentizeData>()
                                                        .otherWrite!
                                                        .write(
                                                            utf8.encode("0"));
                                                  }
                                                }
                                                if (newValue == "Switch Mode") {
                                                  widget.toggleFilamentize!();
                                                }
                                                if (newValue == "Reset Spool") {
                                                  await context
                                                      .read<FilamentizeData>()
                                                      .spoolReset!
                                                      .write(utf8.encode("1"));
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1), () {
                                                    context
                                                        .read<FilamentizeData>()
                                                        .spoolReset!
                                                        .write(
                                                            utf8.encode("0"));
                                                  });
                                                }
                                                if (newValue ==
                                                    "switch color") {
                                                  showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    "Select Color",
                                                                    style: GoogleFonts.montserrat(
                                                                        fontWeight:
                                                                            FontWeight.w600)),
                                                                content: StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.white.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "0",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.black.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "1",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.red.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "2",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.green.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "3",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.blue.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "4",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.yellow.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "5",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.cyan.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "6",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.magenta.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "7",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.purple.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "8",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.brown.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "9",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.orange.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "10",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.gray.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "11",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.limeGreen.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "12",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.navyBlue.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "13",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.silver.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "14",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                        RadioListTile(
                                                                            title:
                                                                                Text(AppLocale.maroon.getString(context), style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                            value: "15",
                                                                            groupValue: selectedColor,
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                selectedColor = value!;
                                                                              });
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          AppLocale.selectedColor.getString(
                                                                              context),
                                                                          style:
                                                                              GoogleFonts.montserrat(fontWeight: FontWeight.w600))),
                                                                  TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        await context
                                                                            .read<FilamentizeData>()
                                                                            .color!
                                                                            .write(utf8.encode(selectedColor));
                                                                        await Future.delayed(
                                                                            const Duration(seconds: 1),
                                                                            () {
                                                                          context
                                                                              .read<FilamentizeData>()
                                                                              .color!
                                                                              .write(utf8.encode("0"));
                                                                        });
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          AppLocale.shootColor.getString(
                                                                              context),
                                                                          style: GoogleFonts.montserrat(
                                                                              fontWeight: FontWeight.w600,
                                                                              color: ColorsAsset.green)))
                                                                ],
                                                              ));
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ] else ...[
                                    SizedBox(height: 15.h),
                                    // shake hand
                                    GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<FilamentizeData>()
                                            .otherWrite
                                            ?.write(utf8.encode("2"));

                                        await player.setSource(
                                            AssetSource("sounds/hello.mp3"));
                                        await player.resume();

                                        await Future.delayed(
                                            Duration(seconds: 1));

                                        await context
                                            .read<FilamentizeData>()
                                            .otherWrite
                                            ?.write(utf8.encode("0"));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 250.h,
                                        decoration: BoxDecoration(
                                            color: ColorsAsset.green,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/shakehand.svg",
                                              width: 100.w,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text("Shake Hand",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 15.h),

                                    // wave hand
                                    GestureDetector(
                                      onTap: () async {
                                        await context
                                            .read<FilamentizeData>()
                                            .otherWrite
                                            ?.write(utf8.encode("1"));

                                        await player.setSource(
                                            AssetSource("sounds/hi.mp3"));
                                        await player.resume();

                                        await Future.delayed(
                                            Duration(seconds: 1));

                                        await context
                                            .read<FilamentizeData>()
                                            .otherWrite
                                            ?.write(utf8.encode("0"));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 250.h,
                                        decoration: BoxDecoration(
                                            color: ColorsAsset.green,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/wavehand.svg",
                                              width: 100.w,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text("Wave Hand",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 15.h),

                                    GestureDetector(
                                      onTap: () async {
                                        await player.setSource(
                                            AssetSource("sounds/eating.wav"));
                                        await player.resume();
                                      },
                                      child: Container(
                                        width: 100.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                            color: ColorsAsset.green,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/sound.svg",
                                              width: 50.w,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text("Talk",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20.h)
                                  ]
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return const Center(
                        child: CircularProgressIndicator(
                            color: ColorsAsset.green));
                  });
            }
            return const Center(
                child: CircularProgressIndicator(color: ColorsAsset.green));
          });
    } else {
      return const Center(
          child: CircularProgressIndicator(color: ColorsAsset.green));
    }
  }
}
