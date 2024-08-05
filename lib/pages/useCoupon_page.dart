import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseCouponPage extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> coupon;
  const UseCouponPage({super.key, required this.coupon});

  @override
  State<UseCouponPage> createState() => _UseCouponPageState();
}

class _UseCouponPageState extends State<UseCouponPage> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 45),
          child: Column(
            children: [
              // coupon slip
              Container(
                decoration: const BoxDecoration(
                    color: ColorsAsset.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // icon + (name + detail)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon
                        const Icon(Icons.food_bank_outlined, size: 88),

                        const SizedBox(width: 25),

                        // name + detail
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name
                            SizedBox(
                              width: 150,
                              child: Text(widget.coupon["title"],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      height: 1)),
                            ),

                            const SizedBox(height: 5),

                            // detail
                            Text(
                              widget.coupon["place"],
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1),
                            )
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 25),

                    // conditions
                    Container(
                      padding: const EdgeInsets.only(left: 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // header
                          Text(
                            "Get ${widget.coupon["title"]}",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 16),

                          // descriptions
                          Text(
                              "- ${AppLocale.forThailandUse.getString(context)}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              maxLines: 2),

                          Text(
                            "- ${AppLocale.cantUseWithOther.getString(context)}",
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),

                          Text("- ${AppLocale.noCashValue.getString(context)}",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // divider
                    const Divider(),

                    const SizedBox(height: 25),

                    // qr code
                    QrImageView(
                        data: widget.coupon.id,
                        version: QrVersions.auto,
                        size: 125),

                    const SizedBox(height: 25)
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // dismiss
              GestureDetector(
                onTap: () async {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(currentUser!.email)
                      .collection("myCoupons")
                      .doc(widget.coupon.id)
                      .delete();
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                      color: ColorsAsset.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
