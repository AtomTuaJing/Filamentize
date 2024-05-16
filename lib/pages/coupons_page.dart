import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_coupon.dart';
import 'package:filamentize2/pages/useCoupon_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  // current user
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsAsset.green,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsAsset.green,
        leading: IconButton(
            icon: Icon(Icons.west),
            color: ColorsAsset.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("My Coupons",
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorsAsset.white)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 37),
          // white container
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              decoration: const BoxDecoration(
                  color: ColorsAsset.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(currentUser!.email)
                      .collection("myCoupons")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final coupon = snapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UseCouponPage(coupon: coupon))),
                              child: MyCoupon(
                                title: coupon["title"],
                                place: coupon["place"],
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text("error: ${snapshot.error}",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w600));
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                            color: ColorsAsset.green));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
