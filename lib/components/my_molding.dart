import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyMolding extends StatelessWidget {
  final modelName;
  final plastictype;
  final plasticUsed;
  final requiredTemp;
  const MyMolding(
      {super.key,
      required this.modelName,
      required this.plasticUsed,
      required this.plastictype,
      required this.requiredTemp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 109,
      decoration: const BoxDecoration(
          color: ColorsAsset.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // mold logo
            const Icon(Icons.catching_pokemon_outlined, size: 81),

            const SizedBox(width: 20),

            // divider
            const VerticalDivider(),

            const SizedBox(width: 20),

            // mold title + detail
            Column(
              children: [
                // title
                Text(modelName,
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold)),

                // details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // type
                    Text("type : $plastictype",
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorsAsset.littleGrey)),

                    // plastic usage
                    Text("plastic : $plasticUsed",
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorsAsset.littleGrey)),

                    // temp
                    Text("temp : $requiredTemp°C",
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorsAsset.littleGrey)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
