import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRecommended extends StatelessWidget {
  final String title;
  final String place;
  final String price;
  final String type;
  final String image;
  const MyRecommended(
      {super.key,
      required this.title,
      required this.place,
      required this.price,
      required this.type,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: Column(
        children: [
          // coupon image + tag
          Stack(
            children: [
              // image
              SizedBox(
                  width: 296,
                  height: 133,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )),

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
            ],
          ),

          // coupon name / description + price
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: const BoxDecoration(
                  color: ColorsAsset.grey,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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

                  // price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // text
                      Text(
                        price,
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),

                      // icon
                      const Icon(Icons.account_balance_wallet_outlined,
                          size: 29)
                    ],
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
