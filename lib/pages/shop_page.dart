import 'package:carousel_slider/carousel_slider.dart';
import 'package:filamentize2/assets/colors.dart';
import 'package:filamentize2/components/my_bestdeal.dart';
import 'package:filamentize2/components/my_recommended.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShopPage extends StatefulWidget {
  ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("images/logo.png", width: 39, height: 39),
        leading: Icon(Icons.local_activity_outlined, size: 29),
        actions: [
          // text
          Text(
            "150",
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.w600),
          ),

          SizedBox(width: 5),

          // wallet icon
          Icon(Icons.account_balance_wallet_outlined, size: 29),

          SizedBox(width: 10)
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
                  Icon(Icons.stars_outlined, size: 24),

                  SizedBox(width: 5),

                  // recommend
                  Text("Recommended",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.w600))
                ],
              ),

              SizedBox(height: 10),

              // recommend list view
              CarouselSlider.builder(
                  itemCount: 4,
                  itemBuilder: ((context, index, realIndex) {
                    return MyRecommended(number: index);
                  }),
                  options: CarouselOptions(
                      height: 183,
                      autoPlay: true,
                      viewportFraction: 1,
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      })),

              SizedBox(height: 5),

              // recommend slider
              buildIndicator(),

              SizedBox(height: 11),

              // best deal text
              Row(
                children: [
                  // recommend icon
                  Icon(Icons.recommend_outlined, size: 24),

                  SizedBox(width: 5),

                  // recommend
                  Text("Best Deal",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.w600))
                ],
              ),

              SizedBox(height: 10),

              // best deal grid view
              Expanded(
                child: GridView.builder(
                  itemCount: 5,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 19,
                      mainAxisSpacing: 21),
                  itemBuilder: (context, index) {
                    return MyBestDeal();
                  },
                ),
              ),
              SizedBox(height: 19)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 4,
        effect: ExpandingDotsEffect(
            dotWidth: 10,
            dotHeight: 10,
            dotColor: ColorsAsset.littleGrey,
            activeDotColor: ColorsAsset.green),
      );
}
