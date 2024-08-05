import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_bestdeal.dart';
import 'package:filamentize2/components/my_recommended.dart';
import 'package:filamentize2/pages/coupons_page.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
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

  // selling things
  var recommended;
  var bestDeal;

  @override
  void didChangeDependencies() {
    recommended = [
      {
        "title": AppLocale.wallpaper.getString(context),
        "place": "BCC",
        "price": 79,
        "type": AppLocale.item.getString(context),
        "image": "images/wallpaper.png"
      },
      {
        "title": AppLocale.stickers.getString(context),
        "place": "BCC",
        "price": 29,
        "type": AppLocale.item.getString(context),
        "image": "images/stickers.png"
      },
      {
        "title": AppLocale.entryCard.getString(context),
        "place": "BCC",
        "price": 99,
        "type": AppLocale.item.getString(context),
        "image": "images/entryCard.png"
      },
    ];

    bestDeal = [
      {
        "title": AppLocale.messengerBag.getString(context),
        "place": "BCC",
        "price": 550,
        "type": AppLocale.item.getString(context),
        "image": "images/messenger.png"
      },
      {
        "title": AppLocale.sportBag.getString(context),
        "place": "BCC",
        "price": 550,
        "type": AppLocale.item.getString(context),
        "image": "images/sportsBag.png"
      },
      {
        "title": AppLocale.bccDolls.getString(context),
        "place": "BCC",
        "price": 479,
        "type": AppLocale.item.getString(context),
        "image": "images/dolls.png"
      },
      {
        "title": AppLocale.lineStickers.getString(context),
        "place": "BCC",
        "price": 79,
        "type": AppLocale.item.getString(context),
        "image": "images/lineSticker.png"
      },
    ];
    super.didChangeDependencies();
  }

  // buy recommended coupon method
  Future<void> buyRecommendedCoupon(var coupon) async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsAsset.green)));

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
    var couponPrice = coupon["price"];

    // check if user have enough wallet to buy
    if (userWallet >= couponPrice) {
      // minus coupon price
      userWallet = userWallet - couponPrice;

      // update user's wallet
      user.update({"wallet": userWallet});

      // add user coupon data
      await userCouponData.add({
        "title": coupon["title"],
        "place": coupon["place"],
      });

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(AppLocale.error.getString(context),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                content: Text(AppLocale.notEnoughWallet,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocale.ok.getString(context),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: ColorsAsset.green)))
                ],
              ));
    }
  }

  // buy best deal coupon method
  Future<void> buyBestDealCoupon(var coupon) async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
            child: CircularProgressIndicator(color: ColorsAsset.green)));

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
    var couponPrice = coupon["price"];

    // check if user have enough wallet to buy
    if (userWallet >= couponPrice) {
      // minus coupon price
      userWallet = userWallet - couponPrice;

      // update user's wallet
      user.update({"wallet": userWallet});

      // add user coupon data
      await userCouponData.add({
        "title": coupon["title"],
        "place": coupon["place"],
      });

      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(AppLocale.error.getString(context),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                content: Text(AppLocale.notEnoughWallet.getString(context),
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocale.ok.getString(context),
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
                    Text(AppLocale.recommended.getString(context),
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),

                const SizedBox(height: 10),

                // recommend list view
                Column(
                  children: [
                    CarouselSlider.builder(
                        itemCount: recommended.length,
                        itemBuilder: ((context, index, realIndex) {
                          final recommendedCoupon = recommended[index];
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          AppLocale.doYouConfirm
                                              .getString(context),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600)),
                                      content: Text(
                                          "${AppLocale.confirmBuying.getString(context)} ${recommendedCoupon["title"]} ${AppLocale.questionMark.getString(context)}",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600)),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                                AppLocale.cancel
                                                    .getString(context),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        TextButton(
                                            onPressed: () async {
                                              await buyRecommendedCoupon(
                                                  recommendedCoupon);
                                            },
                                            child: Text(
                                                AppLocale.confirm
                                                    .getString(context),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorsAsset.green)))
                                      ],
                                    );
                                  });
                            },
                            child: MyRecommended(
                              title: recommendedCoupon["title"],
                              place: recommendedCoupon["place"],
                              type: recommendedCoupon["type"],
                              price: recommendedCoupon["price"].toString(),
                              image: recommendedCoupon["image"],
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
                    buildIndicator(recommended.length),
                  ],
                ),

                const SizedBox(height: 11),

                // best deal text
                Row(
                  children: [
                    // best deal icon
                    const Icon(Icons.recommend_outlined, size: 24),

                    const SizedBox(width: 5),

                    // best deal
                    Text(AppLocale.bestDeal.getString(context),
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),

                const SizedBox(height: 10),

                // best deal grid view
                Expanded(
                  child: GridView.builder(
                    itemCount: bestDeal.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 21,
                            mainAxisSpacing: 19,
                            childAspectRatio: 0.68),
                    itemBuilder: (context, index) {
                      final coupon = bestDeal[index];
                      return GestureDetector(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                      AppLocale.doYouConfirm.getString(context),
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600)),
                                  content: Text(
                                      "${AppLocale.confirmBuying.getString(context)} ${coupon["title"]} ${AppLocale.questionMark.getString(context)}",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600)),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                            AppLocale.cancel.getString(context),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600))),
                                    TextButton(
                                        onPressed: () async {
                                          await buyBestDealCoupon(coupon);
                                        },
                                        child: Text(
                                            AppLocale.confirm
                                                .getString(context),
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                color: ColorsAsset.green)))
                                  ],
                                );
                              });
                        },
                        child: MyBestDeal(
                            title: coupon["title"],
                            place: coupon["place"],
                            price: coupon["price"].toString(),
                            type: coupon["type"],
                            image: coupon["image"]),
                      );
                    },
                  ),
                )
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
