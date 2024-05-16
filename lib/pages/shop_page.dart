import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_bestdeal.dart';
import 'package:filamentize2/components/my_recommended.dart';
import 'package:filamentize2/pages/coupons_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int activeIndex = 0;
  int carouselLength = 0;

  // current user
  final currentUser = FirebaseAuth.instance.currentUser;

  // buy recommended coupon method
  Future<void> buyRecommendedCoupon(String couponDocId) async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsAsset.green)));

    // access coupon
    final coupon = await FirebaseFirestore.instance
        .collection("Recommended")
        .doc(couponDocId)
        .get();

    // access coupon data
    final couponData = coupon.data() as Map<String, dynamic>;

    // access user
    final user =
        FirebaseFirestore.instance.collection("Users").doc(currentUser!.email);

    // access user data
    final userData = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();

    // access user coupon data
    final userCouponData = user.collection("myCoupons");

    var userWallet = userData["wallet"];
    var couponPrice = couponData["price"];

    // check if user have enough wallet to buy
    if (userWallet >= couponPrice) {
      // minus coupon price
      userWallet = userWallet - couponPrice;

      // update user's wallet
      user.update({"wallet": userWallet});

      // add user coupon data
      await userCouponData.add({
        "title": couponData["title"],
        "place": couponData["place"],
        "serialId": coupon.id
      });

      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                content: Text("Not Enough Wallet",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)))
                ],
              ));
    }
  }

  // buy best deal coupon method
  Future<void> buyBestDealCoupon(String couponDocId) async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsAsset.green)));

    // access coupon
    final coupon = await FirebaseFirestore.instance
        .collection("Coupons")
        .doc(couponDocId)
        .get();

    // access coupon data
    final couponData = coupon.data() as Map<String, dynamic>;

    // access user
    final user =
        FirebaseFirestore.instance.collection("Users").doc(currentUser!.email);

    // access user data
    final userData = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();

    // access user coupon data
    final userCouponData = user.collection("myCoupons");

    var userWallet = userData["wallet"];
    var couponPrice = couponData["price"];

    // check if user have enough wallet to buy
    if (userWallet >= couponPrice) {
      // minus coupon price
      userWallet = userWallet - couponPrice;

      // update user's wallet
      user.update({"wallet": userWallet});

      // add user coupon data
      await userCouponData.add({
        "title": couponData["title"],
        "place": couponData["place"],
        "serialId": coupon.id
      });

      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Error",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                content: Text("Not Enough Wallet",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600)))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset("images/logo.png", width: 39, height: 39),
          leading: IconButton(
              icon: const Icon(Icons.local_activity_outlined),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CouponsPage();
                }));
              }),
          actions: [
            // text
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(currentUser!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final wallet =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Text(wallet["wallet"].toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w600));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: 20, fontWeight: FontWeight.w600));
                  }
                  return Text("--",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.w600));
                }),

            const SizedBox(width: 5),

            // wallet icon
            const Icon(Icons.account_balance_wallet_outlined, size: 29),

            const SizedBox(width: 10)
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 23, right: 23, top: 15),
            child: Column(
              children: [
                // recommend text
                Row(
                  children: [
                    // recommend icon
                    const Icon(Icons.stars_outlined, size: 24),

                    const SizedBox(width: 5),

                    // recommend
                    Text("Recommended",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),

                const SizedBox(height: 10),

                // recommend list view
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Recommended")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            CarouselSlider.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: ((context, index, realIndex) {
                                  final recommendedCoupon =
                                      snapshot.data!.docs[index];
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Do you confirm?",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              content: Text(
                                                  "confirm buying ${recommendedCoupon.data()["title"]}",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text("Cancel",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600))),
                                                TextButton(
                                                    onPressed: () async {
                                                      await buyRecommendedCoupon(
                                                          recommendedCoupon.id);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Confirm",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    ColorsAsset
                                                                        .green)))
                                              ],
                                            );
                                          });
                                    },
                                    child: MyRecommended(
                                      title: recommendedCoupon["title"],
                                      place: recommendedCoupon["place"],
                                      type: recommendedCoupon["type"],
                                      price:
                                          recommendedCoupon["price"].toString(),
                                    ),
                                  );
                                }),
                                options: CarouselOptions(
                                  height: 183,
                                  autoPlay: true,
                                  viewportFraction: 1,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeIndex = index;
                                    });
                                  },
                                )),
                            const SizedBox(height: 5),

                            // recommend slider
                            buildIndicator(snapshot.data!.docs.length),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "error: ${snapshot.error}",
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        );
                      }
                      return const Center(
                          child: CircularProgressIndicator(
                              color: ColorsAsset.green));
                    }),

                const SizedBox(height: 11),

                // best deal text
                Row(
                  children: [
                    // recommend icon
                    const Icon(Icons.recommend_outlined, size: 24),

                    const SizedBox(width: 5),

                    // recommend
                    Text("Best Deal",
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),

                const SizedBox(height: 10),

                // best deal grid view
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Coupons")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final coupons = snapshot.data!.docs;
                        return Expanded(
                          child: GridView.builder(
                            itemCount: coupons.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 21,
                                    mainAxisSpacing: 19,
                                    childAspectRatio: 0.68),
                            itemBuilder: (context, index) {
                              final coupon = coupons[index];
                              return GestureDetector(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Do you confirm?",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600)),
                                          content: Text(
                                              "confirm buying ${coupon["title"]}",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600)),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Cancel",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                            TextButton(
                                                onPressed: () async {
                                                  await buyBestDealCoupon(
                                                      coupon.id);
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Confirm",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: ColorsAsset
                                                                .green)))
                                          ],
                                        );
                                      });
                                },
                                child: MyBestDeal(
                                  title: coupon["title"],
                                  place: coupon["place"],
                                  price: coupon["price"].toString(),
                                  type: coupon["type"],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        Text("error: ${snapshot.error}",
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w600));
                      }
                      return const Center(
                          child: CircularProgressIndicator(
                              color: ColorsAsset.green));
                    }),
                const SizedBox(height: 19)
              ],
            ),
          ),
        ));
  }

  Widget buildIndicator(int length) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: const ExpandingDotsEffect(
            dotWidth: 10,
            dotHeight: 10,
            dotColor: ColorsAsset.littleGrey,
            activeDotColor: ColorsAsset.green),
      );
}
