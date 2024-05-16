import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyMolding extends StatelessWidget {
  const MyMolding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 103,
      decoration: BoxDecoration(
          color: ColorsAsset.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // mold logo
            Icon(Icons.catching_pokemon_outlined, size: 81),

            SizedBox(width: 20),

            // divider
            VerticalDivider(),

            SizedBox(width: 20),

            // mold title + detail
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  // title
                  Text("Pokeball",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold)),

                  // details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // type
                      Text("type : LDPE",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorsAsset.littleGrey)),

                      // plastic usage
                      Text("plastic : 540g",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorsAsset.littleGrey)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
