import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                  const Icon(
                    Icons.account_circle_outlined,
                    color: ColorsAsset.white,
                    size: 80,
                  ),

                  const SizedBox(width: 5),

                  // hello user
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // hello
                      Text(
                        "Hello",
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
                padding: const EdgeInsets.only(left: 15, top: 45),
                decoration: const BoxDecoration(
                    color: ColorsAsset.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    // sign out button
                    GestureDetector(
                      onTap: signOut,
                      child: Container(
                        color: ColorsAsset.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
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
                            Text("Sign out",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorsAsset.red))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
