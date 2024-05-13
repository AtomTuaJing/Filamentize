import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoupon extends StatelessWidget {
  const MyCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 96,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: ColorsAsset.green,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // logo
          Icon(
            Icons.food_bank_outlined,
            size: 60,
            color: ColorsAsset.white,
          ),

          SizedBox(width: 25),

          // dashed line
          VerticalDivider(
            color: ColorsAsset.white,
          ),

          SizedBox(width: 25),

          // coupon name + detail
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              Text("Free Meal",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorsAsset.white)),

              // detail
              Text("Bonchon",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorsAsset.white,
                      height: 0.5)),

              SizedBox(height: 8)
            ],
          )
        ],
      ),
    );
  }
}
