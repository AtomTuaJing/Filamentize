import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBestDeal extends StatelessWidget {
  final String title;
  final String place;
  final String price;
  final String type;
  final String image;
  const MyBestDeal(
      {super.key,
      required this.title,
      required this.place,
      required this.price,
      required this.type,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: ColorsAsset.white),
      child: Column(
        children: [
          // coupon image + tag
          Stack(children: [
            // image
            SizedBox(
              width: 155,
              height: 151,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),

            // tag
            Padding(
              padding: const EdgeInsets.only(left: 7, top: 8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                  SizedBox(
                    width: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Text(place,
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w600))
                      ],
                    ),
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
