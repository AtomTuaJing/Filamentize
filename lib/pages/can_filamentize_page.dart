import 'dart:convert';

import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/services/filamentizeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CanFilamentizePage extends StatefulWidget {
  const CanFilamentizePage({super.key});

  @override
  State<CanFilamentizePage> createState() => _CanFilamentizePageState();
}

class _CanFilamentizePageState extends State<CanFilamentizePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.watch<FilamentizeData>().otherNotify != null) {
      context.read<FilamentizeData>().otherNotify!.setNotifyValue(true);
    }
  }

  // state
  String state = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.west, size: 24, color: Colors.black)),
        title: Image.asset("images/logo.png", width: 39, height: 39),
      ),
      body: context.watch<FilamentizeData>().otherNotify != null
          ? StreamBuilder(
              stream:
                  context.read<FilamentizeData>().otherNotify!.onValueReceived,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<String> decodedData =
                      utf8.decode(snapshot.data!).split("/");
                  if (decodedData[2] == "0") {
                    state = "";
                  } else if (decodedData[2] == "1") {
                    state = "cant";
                  } else {
                    state = "can";
                  }
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 23),
                      child: Column(
                        children: [
                          // can be filamentize
                          Flexible(
                            flex: 1,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorsAsset.grey),
                                ).animate(target: state == "can" ? 1 : 0).tint(
                                    duration: 200.ms, color: ColorsAsset.green),
                                Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                      // icon
                                      SvgPicture.asset(
                                        "images/icons/water_bottle_large.svg",
                                        width: 150,
                                        colorFilter: const ColorFilter.mode(
                                            ColorsAsset.littleGrey,
                                            BlendMode.srcIn),
                                      ),

                                      // text
                                      Text("can be Filamentize",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: ColorsAsset.littleGrey))
                                    ])
                                    .animate(target: state == "can" ? 1 : 0)
                                    .tint(duration: 300.ms, color: Colors.white)
                              ],
                            ),
                          ).animate(target: state == "mold" ? 1 : 0).swap(
                              duration: 300.ms,
                              builder: (_, __) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.yellow[700]),
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // icon
                                            const Icon(Icons.recycling,
                                                size: 150, color: Colors.white),

                                            // text
                                            Text("can be Molding",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: ColorsAsset.white))
                                          ])
                                    ],
                                  ).animate().fadeIn(duration: 300.ms)),

                          const SizedBox(height: 15),

                          // divider
                          const Divider(
                            thickness: 3,
                            color: ColorsAsset.littleGrey,
                          ),

                          const SizedBox(height: 15),

                          // can not be filamentize
                          Flexible(
                            flex: 1,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorsAsset.grey),
                                ).animate(target: state == "cant" ? 1 : 0).tint(
                                    duration: 300.ms, color: ColorsAsset.red),
                                Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                      // icon
                                      const Icon(Icons.dangerous_outlined,
                                          size: 150,
                                          color: ColorsAsset.littleGrey),

                                      // text
                                      Text("can not be Filamentize",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: ColorsAsset.littleGrey))
                                    ])
                                    .animate(target: state == "cant" ? 1 : 0)
                                    .tint(duration: 200.ms, color: Colors.white)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                    child: CircularProgressIndicator(color: Colors.green));
              })
          : const Center(
              child: CircularProgressIndicator(
              color: ColorsAsset.green,
            )),
    );
  }
}
