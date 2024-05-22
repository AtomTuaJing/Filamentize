import 'package:filamentize2/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTemp extends StatelessWidget {
  final int rlTemp;
  final int setTemp;
  const MyTemp({super.key, required this.rlTemp, required this.setTemp});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // real time temp
        Text(rlTemp.toString(),
            style: GoogleFonts.montserrat(
                fontSize: 24, fontWeight: FontWeight.w600)),

        const SizedBox(width: 1),

        // arrow ease
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Row(
            children: [
              const Icon(Icons.east, size: 20, color: ColorsAsset.littleGrey),

              const SizedBox(width: 1),

              // set temp
              Text("${setTemp.toString()}°C",
                  style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorsAsset.littleGrey)),
            ],
          ),
        )
      ],
    );
  }
}
