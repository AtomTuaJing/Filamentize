import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_iconbutton.dart';
import 'package:filamentize2/components/my_slider.dart';
import 'package:filamentize2/components/my_temp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageConnected extends StatefulWidget {
  final Function()? toggleFilamentize;
  const HomePageConnected({super.key, required this.toggleFilamentize});

  @override
  State<HomePageConnected> createState() => _HomePageConnectedState();
}

class _HomePageConnectedState extends State<HomePageConnected> {
  double fanOne = 0;
  double fanTwo = 0;
  double spoolMotor = 0;
  double extruder = 0;
  double stepper = 0;
  double vibrator = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Image.asset("images/logo.png", width: 39, height: 39)),
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
                    borderRadius: BorderRadius.all(Radius.circular(12))),
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
                        Column(
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
                                          BorderRadius.all(Radius.circular(2))),
                                ),

                                const SizedBox(width: 2),

                                // on/off text
                                Text("Device On",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),

                            // mode
                            Text("Filamentize Mode",
                                style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: ColorsAsset.littleGrey))
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
                              text: "YELLOW",
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

              const SizedBox(height: 15),

              // stats
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                decoration: const BoxDecoration(
                    color: ColorsAsset.grey,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // temp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon button
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: ColorsAsset.white,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          width: double.infinity,
                                          height: 463,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 30),
                                              // temperature header
                                              Text("Temperature",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600)),

                                              SizedBox(height: 36),

                                              // temp 1 set
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // my icon button
                                                  Column(
                                                    children: [
                                                      // icon button
                                                      MyIconButton(
                                                          rectSize: 59,
                                                          iconSize: 40,
                                                          icon:
                                                              Icons.thermostat),

                                                      // temperature text
                                                      Text("temperature 1",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))
                                                    ],
                                                  ),

                                                  SizedBox(width: 50),

                                                  // set temp
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      // real time temp
                                                      MyTemp(
                                                          rlTemp: 126,
                                                          setTemp: 500),

                                                      // set temp button
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25,
                                                                  vertical: 2),
                                                          decoration: BoxDecoration(
                                                              color: ColorsAsset
                                                                  .littleGrey,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                          child: Row(
                                                            children: [
                                                              // icon
                                                              Icon(Icons
                                                                  .settings_outlined),

                                                              // set text
                                                              Text("Set",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),

                                              SizedBox(height: 53),

                                              // temp 2 set
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // my icon button
                                                  Column(
                                                    children: [
                                                      // icon button
                                                      MyIconButton(
                                                          rectSize: 59,
                                                          iconSize: 40,
                                                          icon:
                                                              Icons.thermostat),

                                                      // temperature text
                                                      Text("temperature 2",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))
                                                    ],
                                                  ),

                                                  SizedBox(width: 40),

                                                  // set temp
                                                  Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      // real time temp
                                                      MyTemp(
                                                          rlTemp: 132,
                                                          setTemp: 500),

                                                      // set temp button
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      25,
                                                                  vertical: 2),
                                                          decoration: BoxDecoration(
                                                              color: ColorsAsset
                                                                  .littleGrey,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                          child: Row(
                                                            children: [
                                                              // icon
                                                              Icon(Icons
                                                                  .settings_outlined),

                                                              // set text
                                                              Text("Set",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600))
                                                            ],
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
                              child: MyIconButton(
                                icon: Icons.device_thermostat,
                                iconSize: 30,
                                rectSize: 44,
                              ),
                            ),
                            Text("Temperature",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w600))
                          ],
                        ),

                        // temp 1
                        Container(
                          width: 115,
                          height: 55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // temp val
                              Container(
                                width: 115,
                                height: 35,
                                child: MyTemp(
                                  rlTemp: 126,
                                  setTemp: 500,
                                ),
                              ),

                              SizedBox(height: 6),

                              // temperature 1
                              Container(
                                width: 115,
                                child: Text(
                                  "temperature 1",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(width: 4),

                        // temp 2
                        Container(
                          width: 115,
                          height: 55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // temp val
                              Container(
                                width: 115,
                                height: 35,
                                child: MyTemp(
                                  rlTemp: 132,
                                  setTemp: 500,
                                ),
                              ),

                              SizedBox(height: 6),

                              // temperature 2
                              Container(
                                width: 115,
                                child: Text(
                                  "temperature 2",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

                    // cooling fans
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // icon button
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: ColorsAsset.white,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 350,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 30),
                                              // cooling fans
                                              Text("Cooling Fans",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600)),

                                              SizedBox(height: 38),

                                              // cooling fans stat
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // icon button 1
                                                  Column(
                                                    children: [
                                                      MyIconButton(
                                                          rectSize: 50,
                                                          iconSize: 35,
                                                          icon:
                                                              Icons.wind_power),
                                                      Text("Cooling Fan 1",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))
                                                    ],
                                                  ),

                                                  SizedBox(width: 5),

                                                  // slider 1
                                                  MySlider(
                                                      sliderValue: fanOne,
                                                      isRotate: true),

                                                  // slider 2
                                                  MySlider(
                                                    sliderValue: fanTwo,
                                                    isRotate: true,
                                                  ),

                                                  SizedBox(width: 5),

                                                  // icon button 2
                                                  Column(
                                                    children: [
                                                      MyIconButton(
                                                          rectSize: 50,
                                                          iconSize: 35,
                                                          icon:
                                                              Icons.wind_power),
                                                      Text("Cooling Fan 2",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: MyIconButton(
                                    rectSize: 44,
                                    iconSize: 30,
                                    icon: Icons.wind_power),
                              ),
                              Text("Cooling Fans",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),

                        Container(
                          width: 115,
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              // fan slider 1
                              MySlider(sliderValue: fanOne, isRotate: false),

                              SizedBox(height: 5),

                              // fan 1 text
                              Text("fan 1",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),

                        // fan slider 2
                        Container(
                          width: 115,
                          child: Column(
                            children: [
                              SizedBox(height: 5),
                              // fan slider 1
                              MySlider(sliderValue: fanOne, isRotate: false),

                              SizedBox(height: 5),

                              // fan 2 text
                              Text("fan 2",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32),

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
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: double.infinity,
                                        height: 550,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 30),
                                            // Speed Mode
                                            Text("Speed Mode",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w600)),

                                            SizedBox(height: 15),

                                            // spool motor
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                // icon button
                                                Column(
                                                  children: [
                                                    // icon
                                                    MyIconButton(
                                                        rectSize: 50,
                                                        iconSize: 36,
                                                        icon: Icons
                                                            .motion_photos_on_outlined),
                                                    // name
                                                    Text("Spool Motor",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),

                                                SizedBox(width: 20),

                                                // slider
                                                MySlider(
                                                    sliderValue: spoolMotor,
                                                    isRotate: false,
                                                    trackHeight: 50,
                                                    sizedBoxWidth: 200),
                                              ],
                                            ),

                                            SizedBox(height: 15),

                                            // extruder
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 13),
                                                // icon button
                                                Column(
                                                  children: [
                                                    // icon
                                                    MyIconButton(
                                                        rectSize: 50,
                                                        iconSize: 36,
                                                        icon: Icons
                                                            .present_to_all_sharp),
                                                    // name
                                                    Text("Extruder",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),

                                                SizedBox(width: 32),

                                                // slider
                                                MySlider(
                                                    sliderValue: extruder,
                                                    isRotate: false,
                                                    trackHeight: 50,
                                                    sizedBoxWidth: 200),
                                              ],
                                            ),

                                            SizedBox(height: 15),

                                            // vibrator
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 20),
                                                // icon button
                                                Column(
                                                  children: [
                                                    // icon
                                                    MyIconButton(
                                                        rectSize: 50,
                                                        iconSize: 36,
                                                        icon: Icons.cyclone),
                                                    // name
                                                    Text("Stepper",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),

                                                // slider
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 35),
                                                  child: MySlider(
                                                      sliderValue: spoolMotor,
                                                      isRotate: false,
                                                      trackHeight: 50,
                                                      sizedBoxWidth: 200),
                                                ),
                                                SizedBox(width: 5)
                                              ],
                                            ),

                                            SizedBox(height: 20),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(width: 20),
                                                // icon button
                                                Column(
                                                  children: [
                                                    // icon
                                                    MyIconButton(
                                                        rectSize: 50,
                                                        iconSize: 36,
                                                        icon: Icons
                                                            .vibration_outlined),
                                                    // name
                                                    Text("Vibrator",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))
                                                  ],
                                                ),

                                                // slider
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 35),
                                                  child: MySlider(
                                                      sliderValue: vibrator,
                                                      isRotate: false,
                                                      trackHeight: 50,
                                                      sizedBoxWidth: 200),
                                                ),
                                                SizedBox(width: 5)
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: MyIconButton(
                                  rectSize: 44,
                                  iconSize: 30,
                                  icon: Icons.speed),
                            ),
                            Text("Speed",
                                style: GoogleFonts.montserrat(
                                    fontSize: 10, fontWeight: FontWeight.w600))
                          ],
                        ),

                        // spool motor
                        Container(
                          width: 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                        Container(
                          width: 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                        Container(
                          width: 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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

              SizedBox(height: 15),

              // start/stop + misc button
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: ColorsAsset.grey,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // start/stop button
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 68, vertical: 9),
                      decoration: BoxDecoration(
                          color: ColorsAsset.red,
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // stop icon
                          Icon(
                            Icons.stop_outlined,
                            color: ColorsAsset.white,
                            size: 28,
                          ),

                          // stop text
                          Text("Stop",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsAsset.white))
                        ],
                      ),
                    ),

                    SizedBox(width: 8),

                    // misc button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorsAsset.littleGrey,
                      ),
                      child: PopupMenuButton(
                        color: ColorsAsset.littleGrey,
                        icon: Icon(Icons.more_horiz,
                            size: 30, color: ColorsAsset.white),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(
                              "Select Color",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: ColorsAsset.white),
                            ),
                            value: "switch color",
                          ),
                          PopupMenuItem(
                            child: Text(
                              "Switch Mode",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: ColorsAsset.white),
                            ),
                            value: "Switch Mode",
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
}
