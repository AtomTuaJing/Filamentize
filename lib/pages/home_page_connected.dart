import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_button.dart';
import 'package:filamentize2/components/my_iconbutton.dart';
import 'package:filamentize2/components/my_slider.dart';
import 'package:filamentize2/components/my_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageConnected extends StatefulWidget {
  const HomePageConnected({super.key});

  @override
  State<HomePageConnected> createState() => _HomePageConnectedState();
}

class _HomePageConnectedState extends State<HomePageConnected> {
  double fanOne = 0;
  double fanTwo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("images/logo.png", width: 39, height: 39),
        actions: [Icon(Icons.add, size: 29), SizedBox(width: 10)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
          child: Column(
            children: [
              // filamentize image + status + selected color
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
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

                        SizedBox(width: 20),

                        // divider
                        Container(
                            width: 2,
                            height: 60,
                            color: ColorsAsset.littleGrey),

                        SizedBox(width: 20),

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
                                  decoration: BoxDecoration(
                                      color: ColorsAsset.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),

                                SizedBox(width: 2),

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

              SizedBox(height: 15),

              // stats
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                decoration: BoxDecoration(
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
                            MyIconButton(
                              icon: Icons.device_thermostat,
                              iconSize: 30,
                              rectSize: 44,
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
                              MyIconButton(
                                  rectSize: 44,
                                  iconSize: 30,
                                  icon: Icons.wind_power),
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
                              MySlider(sliderValue: fanOne),

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
                              MySlider(sliderValue: fanOne),

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
                            MyIconButton(
                                rectSize: 44, iconSize: 30, icon: Icons.speed),
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
                              Text("60%",
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
                              Text("80%",
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
                              Text("90%",
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
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: ColorsAsset.grey,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // start/stop button
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 68, vertical: 5),
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
                          ),

                          // stop text
                          Text("Stop",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsAsset.white))
                        ],
                      ),
                    ),

                    SizedBox(width: 8),

                    // misc button
                    Container(
                      width: 45,
                      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: ColorsAsset.littleGrey,
                      ),
                      child:
                          Icon(Icons.menu, size: 30, color: ColorsAsset.white),
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
