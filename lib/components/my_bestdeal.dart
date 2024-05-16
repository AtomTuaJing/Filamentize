import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBestDeal extends StatelessWidget {
  final String title;
  final String place;
  final String price;
  final String type;
  const MyBestDeal(
      {super.key,
      required this.title,
      required this.place,
      required this.price,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: ColorsAsset.white),
      child: Column(
        children: [
          // coupon image + tag
          Stack(children: [
            // image
            Image.asset("images/filamentizeMachine.png",
                width: 155, height: 151),

            // tag
            Padding(
              padding: const EdgeInsets.only(left: 7, top: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: ColorsAsset.white,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  type,
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            )
          ]),

          // name / description + cost
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
              color: ColorsAsset.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // name + description
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.montserrat(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Text(place,
                          style: GoogleFonts.montserrat(
                              fontSize: 12, fontWeight: FontWeight.w600))
                    ],
                  ),
                  // cost
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // text
                        Text(
                          price,
                          style: GoogleFonts.montserrat(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),

                        // icon
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 18)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
