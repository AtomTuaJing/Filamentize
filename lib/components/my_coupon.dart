import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoupon extends StatelessWidget {
  final String title;
  final String place;
  const MyCoupon({super.key, required this.title, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 96,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
        color: ColorsAsset.green,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          // logo
          const SizedBox(
            width: 60,
            child: Icon(
              Icons.food_bank_outlined,
              size: 60,
              color: ColorsAsset.white,
            ),
          ),

          const SizedBox(width: 20),

          // dashed line
          const VerticalDivider(
            color: ColorsAsset.white,
          ),

          const SizedBox(width: 25),

          // coupon name + detail
          SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorsAsset.white,
                      height: 1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // detail
                Text(place,
                    style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: ColorsAsset.white,
                        height: 0.5)),

                const SizedBox(height: 8)
              ],
            ),
          )
        ],
      ),
    );
  }
}
