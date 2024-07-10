import 'dart:convert';

import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_iconbutton.dart';
import 'package:filamentize2/components/my_slider.dart';
import 'package:filamentize2/components/my_temp.dart';
import 'package:filamentize2/pages/can_filamentize_page.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:flutter/material.dart';
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
  List<String> Options = [
    "White",
    "Black",
    "Red",
    "Green",
    "Blue",
    "Yellow",
    "Cyan",
    "Magenta",
    "Purple",
    "Brown",
    "Orange",
    "Gray",
    "Lime Green",
    "Navy Blue",
    "Silver",
    "Maroon"
  ];

  // text editing controllers
  var setTemp01Controller = TextEditingController();
  var setTemp02Controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.watch<FilamentizeData>().filamentizeThree != null) {
      context.read<FilamentizeData>().filamentizeThree!.setNotifyValue(true);
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
    if (context.watch<FilamentizeData>().filamentizeDevice != null) {
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
              vibrator = double.parse(decodedFilamentizeThreeNotifyData[3]);
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
                    padding:
                        const EdgeInsets.only(left: 23, right: 23, top: 15),
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
                                          children: [
                                            // status color + on/off text
                                            Row(
                                              children: [
                                                // status color
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              ColorsAsset.green,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          2))),
                                                ),

                                                const SizedBox(width: 2),

                                                // on/off text
                                                Text("Device On",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))
                                              ],
                                            ),

                                            // mode
                                            Text("Filamentize Mode",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        ColorsAsset.littleGrey))
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              ColorsAsset.red,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          2))),
                                                ),

                                                const SizedBox(width: 2),

                                                // on/off text
                                                Text("Device Off",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))
                                              ],
                                            ),

                                            // mode
                                            Text("Filamentize Mode",
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
                                        text: "selected color : ",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: selectedColor,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                              .decode(snapshot.data!)
                                              .split("/");
                                      temp01 = int.parse(
                                          decodedFilamentizeOneNotifyData[0]);
                                      temp02 = int.parse(
                                          decodedFilamentizeOneNotifyData[1]);
                                      setTemp01 = int.parse(
                                          decodedFilamentizeOneNotifyData[2]);
                                      setTemp02 = int.parse(
                                          decodedFilamentizeOneNotifyData[3]);
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
                                                        return SizedBox(
                                                            width:
                                                                double.infinity,
                                                            height: 463,
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                    height: 30),
                                                                // temperature header
                                                                Text(
                                                                    "Temperature",
                                                                    style: GoogleFonts.montserrat(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w600)),

                                                                const SizedBox(
                                                                    height: 36),

                                                                // temp 1 set
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // my icon button
                                                                    Column(
                                                                      children: [
                                                                        // icon button
                                                                        const MyIconButton(
                                                                            rectSize:
                                                                                59,
                                                                            iconSize:
                                                                                40,
                                                                            icon:
                                                                                Icons.thermostat),

                                                                        // temperature text
                                                                        Text(
                                                                            "temperature 1",
                                                                            style:
                                                                                GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600))
                                                                      ],
                                                                    ),

                                                                    const SizedBox(
                                                                        width:
                                                                            50),

                                                                    // set temp
                                                                    Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        // real time temp
                                                                        MyTemp(
                                                                            rlTemp:
                                                                                temp01,
                                                                            setTemp:
                                                                                setTemp01),

                                                                        // set temp button
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 10),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => AlertDialog(
                                                                                        title: Text("Set Temperature", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                                                                                        content: TextField(
                                                                                          controller: setTemp01Controller,
                                                                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                                                                                          decoration: InputDecoration(hintText: setTemp01.toString(), hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey)),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              child: Text("Cancel", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600))),
                                                                                          TextButton(
                                                                                              onPressed: () async {
                                                                                                await context.read<FilamentizeData>().temp01!.write(utf8.encode(setTemp01Controller.text));
                                                                                                Navigator.pop(context);
                                                                                                Navigator.pop(context);
                                                                                                setTemp01Controller.clear();
                                                                                              },
                                                                                              child: Text("OK", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.green)))
                                                                                        ],
                                                                                      ));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                                                                              decoration: const BoxDecoration(color: ColorsAsset.littleGrey, borderRadius: BorderRadius.all(Radius.circular(12))),
                                                                              child: Row(
                                                                                children: [
                                                                                  // icon
                                                                                  const Icon(Icons.settings_outlined),

                                                                                  // set text
                                                                                  Text("Set", style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),

                                                                const SizedBox(
                                                                    height: 53),

                                                                // temp 2 set
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    // my icon button
                                                                    Column(
                                                                      children: [
                                                                        // icon button
                                                                        const MyIconButton(
                                                                            rectSize:
                                                                                59,
                                                                            iconSize:
                                                                                40,
                                                                            icon:
                                                                                Icons.thermostat),

                                                                        // temperature text
                                                                        Text(
                                                                            "temperature 2",
                                                                            style:
                                                                                GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600))
                                                                      ],
                                                                    ),

                                                                    const SizedBox(
                                                                        width:
                                                                            40),

                                                                    // set temp
                                                                    Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        // real time temp
                                                                        MyTemp(
                                                                            rlTemp:
                                                                                temp02,
                                                                            setTemp:
                                                                                setTemp02),

                                                                        // set temp button
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 10),
                                                                          child:
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => AlertDialog(
                                                                                        title: Text("Set Temperature 2",
                                                                                            style: GoogleFonts.montserrat(
                                                                                              fontWeight: FontWeight.w600,
                                                                                            )),
                                                                                        content: TextField(
                                                                                          controller: setTemp02Controller,
                                                                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.littleGrey),
                                                                                        ),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                              child: Text("Cancel", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.dark))),
                                                                                          TextButton(
                                                                                              onPressed: () async {
                                                                                                await context.read<FilamentizeData>().temp02!.write(utf8.encode(setTemp02Controller.text));
                                                                                                Navigator.pop(context);
                                                                                                Navigator.pop(context);
                                                                                                setTemp02Controller.clear();
                                                                                              },
                                                                                              child: Text("OK", style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, color: ColorsAsset.green)))
                                                                                        ],
                                                                                      ));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                                                                              decoration: const BoxDecoration(color: ColorsAsset.littleGrey, borderRadius: BorderRadius.all(Radius.circular(12))),
                                                                              child: Row(
                                                                                children: [
                                                                                  // icon
                                                                                  const Icon(Icons.settings_outlined),

                                                                                  // set text
                                                                                  Text("Set", style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ));
                                                      });
                                                },
                                                child: const MyIconButton(
                                                  icon: Icons.device_thermostat,
                                                  iconSize: 30,
                                                  rectSize: 44,
                                                ),
                                              ),
                                              Text("Temperature",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),

                                          // temp 1
                                          SizedBox(
                                            width: 115,
                                            height: 55,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // temp val
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: MyTemp(
                                                    rlTemp: temp01,
                                                    setTemp: setTemp01,
                                                  ),
                                                ),

                                                const SizedBox(height: 6),

                                                // temperature 1
                                                Text(
                                                  "temperature 1",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),

                                          const SizedBox(width: 4),

                                          // temp 2
                                          SizedBox(
                                            width: 115,
                                            height: 55,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // temp val
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: MyTemp(
                                                    rlTemp: temp02,
                                                    setTemp: setTemp02,
                                                  ),
                                                ),

                                                const SizedBox(height: 6),

                                                // temperature 2
                                                Text(
                                                  "temperature 2",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    if (snapshot.hasError) {
                                      return Text("error: ${snapshot.error}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600));
                                    }
                                    return const Center(
                                        child: LinearProgressIndicator(
                                            color: ColorsAsset.green));
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
                                              .decode(snapshot.data!)
                                              .split("/");
                                      setFanOne = double.parse(
                                          decodedFilamentizeTwoNotifyData[2]);
                                      setFanTwo = double.parse(
                                          decodedFilamentizeTwoNotifyData[3]);
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // icon button
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 3),
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
                                                            ColorsAsset.white,
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return SizedBox(
                                                              height: 350,
                                                              width: double
                                                                  .infinity,
                                                              child: Column(
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          30),
                                                                  // cooling fans
                                                                  Text(
                                                                      "Cooling Fans",
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize:
                                                                              24,
                                                                          fontWeight:
                                                                              FontWeight.w600)),
                                                                  const SizedBox(
                                                                      height:
                                                                          38),

                                                                  // cooling fans stat
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
                                                                            Colors.transparent),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        // icon button 1
                                                                        Column(
                                                                          children: [
                                                                            const MyIconButton(
                                                                                rectSize: 50,
                                                                                iconSize: 35,
                                                                                icon: Icons.wind_power),
                                                                            Text("Cooling Fan 1",
                                                                                style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                          ],
                                                                        ),

                                                                        const SizedBox(
                                                                            width:
                                                                                5),

                                                                        // slider 1
                                                                        SizedBox(
                                                                          width:
                                                                              60,
                                                                          child: Stack(
                                                                              alignment: Alignment.center,
                                                                              children: [
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
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Text("${setFanOneCopy.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                              ]),
                                                                        ),

                                                                        // slider 2
                                                                        SizedBox(
                                                                          width:
                                                                              60,
                                                                          child: Stack(
                                                                              alignment: Alignment.center,
                                                                              children: [
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
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Text("${setFanTwoCopy.round().toString()}%", style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w600, color: ColorsAsset.white))
                                                                              ]),
                                                                        ),

                                                                        const SizedBox(
                                                                            width:
                                                                                5),

                                                                        // icon button 2
                                                                        Column(
                                                                          children: [
                                                                            const MyIconButton(
                                                                                rectSize: 50,
                                                                                iconSize: 35,
                                                                                icon: Icons.wind_power),
                                                                            Text("Cooling Fan 2",
                                                                                style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  const SizedBox(
                                                                      height:
                                                                          5),

                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            0.5),
                                                                    decoration: const BoxDecoration(
                                                                        color: ColorsAsset
                                                                            .green,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10))),
                                                                    child: TextButton(
                                                                        onPressed: () async {
                                                                          await context
                                                                              .read<FilamentizeData>()
                                                                              .coolingFan01!
                                                                              .write(utf8.encode(setFanOneCopy.toString()));
                                                                          await context
                                                                              .read<FilamentizeData>()
                                                                              .coolingFan02!
                                                                              .write(utf8.encode(setFanTwoCopy.toString()));
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text("Update", style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600, color: ColorsAsset.white))),
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          });
                                                        });
                                                  },
                                                  child: const MyIconButton(
                                                      rectSize: 44,
                                                      iconSize: 30,
                                                      icon: Icons.wind_power),
                                                ),
                                                Text("Cooling Fans",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 10,
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
                                                const SizedBox(height: 5),
                                                // fan slider 1
                                                MySlider(
                                                  sliderValue: setFanOne,
                                                  isRotate: false,
                                                  setFanSpeed: (value) {
                                                    context
                                                        .read<FilamentizeData>()
                                                        .coolingFan01!
                                                        .write(
                                                            utf8.encode(value));
                                                  },
                                                ),

                                                const SizedBox(height: 5),

                                                // fan 1 text
                                                Text("fan 1",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 10,
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
                                                const SizedBox(height: 5),
                                                // fan slider 2
                                                MySlider(
                                                    sliderValue: setFanTwo,
                                                    isRotate: false,
                                                    setFanSpeed: (value) {
                                                      context
                                                          .read<
                                                              FilamentizeData>()
                                                          .coolingFan02!
                                                          .write(utf8
                                                              .encode(value));
                                                    }),

                                                const SizedBox(height: 5),

                                                // fan 2 text
                                                Text("fan 2",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text("error: ${snapshot.error}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600));
                                    }
                                    return const Center(
                                        child: LinearProgressIndicator(
                                            color: ColorsAsset.green));
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
                                                  width: double.infinity,
                                                  height: 550,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 30),
                                                      // Speed Mode
                                                      Text("Speed Mode",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),

                                                      const SizedBox(
                                                          height: 15),

                                                      // spool motor
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // icon button
                                                          Column(
                                                            children: [
                                                              // icon
                                                              const MyIconButton(
                                                                  rectSize: 50,
                                                                  iconSize: 36,
                                                                  icon: Icons
                                                                      .motion_photos_on_outlined),
                                                              // name
                                                              Text(
                                                                  "Spool Motor",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ],
                                                          ),

                                                          const SizedBox(
                                                              width: 20),

                                                          // slider
                                                          MySlider(
                                                              sliderValue:
                                                                  spoolMotor,
                                                              isRotate: false,
                                                              trackHeight: 50,
                                                              sizedBoxWidth:
                                                                  200,
                                                              setFanSpeed:
                                                                  (value) {
                                                                print(context
                                                                    .read<
                                                                        FilamentizeData>()
                                                                    .spoolMotor!);
                                                                context
                                                                    .read<
                                                                        FilamentizeData>()
                                                                    .spoolMotor!
                                                                    .write(utf8
                                                                        .encode(
                                                                            value));
                                                              }),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                          height: 15),

                                                      // extruder
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                              width: 13),
                                                          // icon button
                                                          Column(
                                                            children: [
                                                              // icon
                                                              const MyIconButton(
                                                                  rectSize: 50,
                                                                  iconSize: 36,
                                                                  icon: Icons
                                                                      .present_to_all_sharp),
                                                              // name
                                                              Text("Extruder",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ],
                                                          ),

                                                          const SizedBox(
                                                              width: 32),

                                                          // slider
                                                          MySlider(
                                                              sliderValue:
                                                                  extruder,
                                                              isRotate: false,
                                                              trackHeight: 50,
                                                              sizedBoxWidth:
                                                                  200,
                                                              setFanSpeed:
                                                                  (value) {
                                                                context
                                                                    .read<
                                                                        FilamentizeData>()
                                                                    .extruder!
                                                                    .write(utf8
                                                                        .encode(
                                                                            value));
                                                              }),
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                          height: 15),

                                                      // vibrator
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                              width: 20),
                                                          // icon button
                                                          Column(
                                                            children: [
                                                              // icon
                                                              const MyIconButton(
                                                                  rectSize: 50,
                                                                  iconSize: 36,
                                                                  icon: Icons
                                                                      .cyclone),
                                                              // name
                                                              Text("Stepper",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ],
                                                          ),

                                                          // slider
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 35),
                                                            child: MySlider(
                                                                sliderValue:
                                                                    stepper,
                                                                isRotate: false,
                                                                trackHeight: 50,
                                                                sizedBoxWidth:
                                                                    200,
                                                                setFanSpeed:
                                                                    (value) {
                                                                  context
                                                                      .read<
                                                                          FilamentizeData>()
                                                                      .stepper!
                                                                      .write(utf8
                                                                          .encode(
                                                                              value));
                                                                }),
                                                          ),
                                                          const SizedBox(
                                                              width: 5)
                                                        ],
                                                      ),

                                                      const SizedBox(
                                                          height: 20),

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SizedBox(
                                                              width: 20),
                                                          // icon button
                                                          Column(
                                                            children: [
                                                              // icon
                                                              const MyIconButton(
                                                                  rectSize: 50,
                                                                  iconSize: 36,
                                                                  icon: Icons
                                                                      .vibration_outlined),
                                                              // name
                                                              Text("Vibrator",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ],
                                                          ),

                                                          // slider
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 35),
                                                            child: MySlider(
                                                                sliderValue:
                                                                    vibrator,
                                                                isRotate: false,
                                                                trackHeight: 50,
                                                                sizedBoxWidth:
                                                                    200,
                                                                setFanSpeed:
                                                                    (value) {
                                                                  context
                                                                      .read<
                                                                          FilamentizeData>()
                                                                      .vibrator!
                                                                      .write(utf8
                                                                          .encode(
                                                                              value));
                                                                }),
                                                          ),
                                                          const SizedBox(
                                                              width: 5)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: const MyIconButton(
                                            rectSize: 44,
                                            iconSize: 30,
                                            icon: Icons.speed),
                                      ),
                                      Text("Speed",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600))
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
                                        Text("${spoolMotor.round()}%",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),

                                        // spool motor
                                        Text("spool motor",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600))
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
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),

                                        // spool motor
                                        Text("extruder",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600))
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
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),

                                        // spool motor
                                        Text("stepper",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600))
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
                                              Text("Stop",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                              Text("Start",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                        "Select Color",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: ColorsAsset.white),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "Switch Mode",
                                      child: Text(
                                        "Switch Mode",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: ColorsAsset.white),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "Plastic Checking",
                                      child: Text(
                                        "Plastic Checking",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: ColorsAsset.white),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "Reset Spool",
                                      child: Text(
                                        "Reset Spool",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: ColorsAsset.white),
                                      ),
                                    ),
                                  ],
                                  onSelected: (newValue) async {
                                    if (newValue == "Plastic Checking") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CanFilamentizePage()));
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
                                          const Duration(seconds: 1), () {
                                        context
                                            .read<FilamentizeData>()
                                            .spoolReset!
                                            .write(utf8.encode("0"));
                                      });
                                    }
                                    if (newValue == "switch color") {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text("Select Color",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                content: StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                  return SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        RadioListTile(
                                                            title: Text("White",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "1",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Black",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "2",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Red",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "3",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Green",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "4",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Blue",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "5",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Yellow",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "6",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Cyan",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "7",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Magenta",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "8",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Purple",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "9",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Brown",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "10",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Orange",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "11",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text("Gray",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "12",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Lime Green",
                                                                style: GoogleFonts.montserrat(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            value: "13",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Navy Blue",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "14",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Silver",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "15",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Maroon",
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600)),
                                                            value: "16",
                                                            groupValue:
                                                                selectedColor,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedColor =
                                                                    value!;
                                                              });
                                                            }),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Set Color",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await context
                                                            .read<
                                                                FilamentizeData>()
                                                            .color!
                                                            .write(utf8.encode(
                                                                selectedColor));
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1),
                                                            () {
                                                          context
                                                              .read<
                                                                  FilamentizeData>()
                                                              .color!
                                                              .write(utf8
                                                                  .encode("0"));
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Shoot Color",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: ColorsAsset
                                                                      .green)))
                                                ],
                                              ));
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
    } else {
      return const Center(
          child: CircularProgressIndicator(color: ColorsAsset.green));
    }
  }
}
