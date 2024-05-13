import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_coupon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsAsset.green,
        leading: Icon(Icons.west, size: 24, color: ColorsAsset.white),
        title: Text("My Coupons",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorsAsset.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 37),
          // white container
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              decoration: BoxDecoration(
                  color: ColorsAsset.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return MyCoupon();
                  }),
            ),
          )
        ],
      ),
    );
  }
}
