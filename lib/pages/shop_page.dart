import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_bestdeal.dart';
import 'package:filamentize2/components/my_recommended.dart';
import 'package:filamentize2/pages/coupons_page.dart';
import 'package:filamentize2/services/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  // page state
  String pageState = "shop";

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                // shop and leaderboard
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // shop
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageState = "shop";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: pageState == "shop"
                                ? ColorsAsset.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("Shop",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: pageState == "shop"
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                    ),

                    SizedBox(width: 30.w),

                    // leaderboard
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageState = "leaderboard";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: pageState == "leaderboard"
                                ? ColorsAsset.green
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("Leaderboard",
                            style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: pageState == "leaderboard"
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                    ),
                  ],
                ),

                if (pageState == "shop") ...[
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          ColorsAsset.green)))
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
                                        AppLocale.doYouConfirm
                                            .getString(context),
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600)),
                                    content: Text(
                                        "${AppLocale.confirmBuying.getString(context)} ${coupon["title"]} ${AppLocale.questionMark.getString(context)}",
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
                ] else if (pageState == "leaderboard")
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .orderBy("wallet", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final users = snapshot.data?.docs;
                          final userOne =
                              users?[0].data() as Map<String, dynamic>;
                          final userTwo =
                              users?[1].data() as Map<String, dynamic>;
                          final userThree =
                              users?[2].data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              SizedBox(height: 20.h),
                              Container(
                                width: double.infinity,
                                height: 240,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(height: 140),
                                        Image.asset("images/places.png"),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // second place
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          width: 80.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 70.h),
                                              // wallet amount
                                              Text(
                                                  "${(userTwo["wallet"] / 1000).toStringAsFixed(2)}K",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),

                                              SizedBox(height: 10.h),

                                              // icon
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                width: 54.w,
                                                height: 54.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorsAsset.littleGrey),
                                                child: userTwo["profile"] != ""
                                                    ? Image.network(
                                                        userTwo["profile"])
                                                    : null,
                                              ),

                                              SizedBox(height: 5.h),

                                              // name
                                              Text(userTwo["username"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ],
                                          ),
                                        ),

                                        // first place
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 80.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // wallet amount
                                              Text(
                                                  "${(userOne["wallet"] / 1000).toStringAsFixed(2)}K",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),

                                              SizedBox(height: 10.h),

                                              // icon
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                width: 75.w,
                                                height: 75.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorsAsset.littleGrey),
                                                child: userOne["profile"] != ""
                                                    ? Image.network(
                                                        userOne["profile"])
                                                    : null,
                                              ),

                                              SizedBox(height: 5.h),

                                              // name
                                              Text(userOne["username"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ],
                                          ),
                                        ),

                                        // third place
                                        Container(
                                          width: 80.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 95.h),
                                              // wallet amount
                                              Text(
                                                  "${(userThree["wallet"] / 1000).toStringAsFixed(2)}K",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),

                                              SizedBox(height: 10.h),

                                              // icon
                                              Container(
                                                clipBehavior: Clip.hardEdge,
                                                width: 54.w,
                                                height: 54.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        ColorsAsset.littleGrey),
                                                child: userThree["profile"] !=
                                                        ""
                                                    ? Image.network(
                                                        userThree["profile"])
                                                    : null,
                                              ),

                                              SizedBox(height: 5.h),

                                              // name
                                              Text(userThree["username"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 35.h),
                              SizedBox(
                                height: 290.h,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: users!.length - 3,
                                    itemBuilder: (context, index) => Ranking(
                                          index: index,
                                          amount:
                                              users[index + 3]["wallet"] / 1000,
                                          username: users[index + 3]
                                              ["username"],
                                          rank: users[index + 3]["level"],
                                          profile: users[index + 3]["profile"],
                                        )),
                              )
                            ],
                          );
                        }
                        return Center(
                            child: CircularProgressIndicator(
                                color: ColorsAsset.green));
                      })
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

class Ranking extends StatelessWidget {
  Ranking(
      {super.key,
      required this.index,
      required this.amount,
      required this.username,
      required this.rank,
      required this.profile});

  int index;
  double amount;
  String username;
  String rank;
  String profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      height: 100.h,
      decoration: BoxDecoration(
          color: ColorsAsset.grey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
            child: Container(
              width: 80.w,
              height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("#${index + 4}",
                      style: GoogleFonts.montserrat(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  Text("${(amount).toStringAsFixed(2)}K",
                      style: GoogleFonts.montserrat(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                          height: .5.h)),
                ],
              ),
            ),
          ),
          VerticalDivider(
            thickness: 2.sp,
            color: Colors.black,
          ),
          SizedBox(width: 8.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // profile
              Container(
                width: 63.w,
                height: 65.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[800]),
                child: profile != ""
                    ? Image.network(profile, fit: BoxFit.cover)
                    : null,
              ),

              SizedBox(width: 7.w),

              // name & rank
              Container(
                width: 110.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                    Text(rank,
                        style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.normal,
                            color: ColorsAsset.green)),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
