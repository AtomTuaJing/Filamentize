import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/main.dart';
import 'package:filamentize2/pages/editProfile_page.dart';
import 'package:filamentize2/services/auth.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:filamentize2/services/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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

  // sign out method
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // current user
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsAsset.green,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorsAsset.green,
          title: Image.asset("images/logo.png",
              width: 39, height: 39, color: ColorsAsset.white),
        ),
        body: Column(
          children: [
            // user profile + hello user
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 25),
              child: Row(
                children: [
                  // user profile
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(currentUser!.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var userData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          if (userData["profile"] != "") {
                            return Container(
                              width: 80,
                              clipBehavior: Clip.hardEdge,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.network(userData["profile"]),
                            );
                          }
                          return const Icon(
                            Icons.account_circle_outlined,
                            color: ColorsAsset.white,
                            size: 80,
                          );
                        }
                        return const SizedBox(
                            height: 80,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white)));
                      }),

                  const SizedBox(width: 10),

                  // hello user
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // hello
                      Text(
                        AppLocale.hello.getString(context),
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsAsset.white),
                      ),

                      // username
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Users")
                              .doc(currentUser!.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final userData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Text(
                                userData["username"],
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsAsset.white),
                              );
                            } else if (snapshot.hasData) {
                              return Text(
                                "error: ${snapshot.error}",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsAsset.white),
                              );
                            }
                            return Text(
                              "--",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsAsset.white),
                            );
                          })
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 45),

            // white container
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 15.w, top: 45.h),
                decoration: const BoxDecoration(
                    color: ColorsAsset.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users")
                        .doc(currentUser?.email)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        var recycled_total = data["recycled_total"];
                        var points = data["wallet"];
                        var bottle_recycled = data["bottle_recycled"];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 105.w,
                                    height: 105.h,
                                    decoration: BoxDecoration(
                                        color: ColorsAsset.green,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 85.w,
                                          height: 45.h,
                                          child: Text("Reclyed Total",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 12.w,
                                              height: 20.h,
                                              child: Text("= ",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white)),
                                            ),
                                            SizedBox(
                                              child: Text("${recycled_total}g",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 7.5.w),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 105.w,
                                    height: 105.h,
                                    decoration: BoxDecoration(
                                        color: ColorsAsset.green,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 85.w,
                                          height: 45.w,
                                          child: Text("Points",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 12.w,
                                              height: 20.h,
                                              child: Text("= ",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white)),
                                            ),
                                            Text("$points",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 7.5.w),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 105.w,
                                    height: 105.h,
                                    decoration: BoxDecoration(
                                        color: ColorsAsset.green,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          width: 85.w,
                                          height: 45.h,
                                          child: Text("Bottle Recycled",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 12.w,
                                              height: 20.h,
                                              child: Text("≈ ",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white)),
                                            ),
                                            Text("$bottle_recycled",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 15.h),

                            // edit profile
                            GestureDetector(
                              onTap: () async {
                                String refresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfilePage()));

                                if (refresh == "refresh") {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Auth()),
                                    (route) => false,
                                  );
                                }
                              },
                              child: Container(
                                color: ColorsAsset.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    // sign out icon
                                    Icon(
                                      Icons.edit,
                                      size: 24,
                                      color: Colors.yellow[800],
                                    ),

                                    const SizedBox(width: 10),

                                    // edit profile
                                    Text(
                                        AppLocale.editProfile
                                            .getString(context),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.yellow[800]))
                                  ],
                                ),
                              ),
                            ),

                            // sign out button
                            GestureDetector(
                              onTap: signOut,
                              child: Container(
                                color: ColorsAsset.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    // sign out icon
                                    const Icon(
                                      Icons.logout,
                                      size: 24,
                                      color: ColorsAsset.red,
                                    ),

                                    const SizedBox(width: 10),

                                    // sign out
                                    Text(AppLocale.signOut.getString(context),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: ColorsAsset.red))
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }

                      return Center(
                          child: CircularProgressIndicator(
                              color: ColorsAsset.green));
                    }),
              ),
            )
          ],
        ));
  }
}
