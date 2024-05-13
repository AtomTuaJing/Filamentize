import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseCouponPage extends StatelessWidget {
  const UseCouponPage({super.key});

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
                decoration: BoxDecoration(
                    color: ColorsAsset.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // icon + (name + detail)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // icon
                        Icon(Icons.food_bank_outlined, size: 88),

                        SizedBox(width: 25),

                        // name + detail
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name
                            Text("Free Meal",
                                style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1)),

                            // detail
                            Text(
                              "Bonchon",
                              style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  height: 1),
                            )
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 25),

                    // conditions
                    Container(
                      padding: EdgeInsets.only(left: 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // header
                          Text(
                            "Get 1 Free Meal",
                            style: GoogleFonts.montserrat(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),

                          SizedBox(height: 16),

                          // descriptions
                          Text("- Redeemable at all Bonchon in Thailand",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, fontWeight: FontWeight.w500)),

                          Text(
                            "- Not valid with any other discount and promotions.",
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),

                          Text("- No Cash Value",
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    SizedBox(height: 35),

                    // divider
                    Divider(),

                    SizedBox(height: 25),

                    // qr code
                    QrImageView(
                        data: "1234567890",
                        version: QrVersions.auto,
                        size: 125),

                    SizedBox(height: 25)
                  ],
                ),
              ),

              SizedBox(height: 30),

              // dismiss
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                    color: ColorsAsset.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.close,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
