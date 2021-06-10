import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/swiper_pagination_style.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/urlLauncher.dart';
import 'package:get/get.dart';

import '../../../urls.dart';

class _Slide {
  _Slide(
      {@required this.title,
      @required this.desc,
      @required this.image,
      @required this.clickHint,
      @required this.onClick});

  String title;
  String desc;
  String image;
  String clickHint;
  Function onClick;
}

class ContextualArea extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<_Slide> slides = [
      _Slide(
          title: "Foodz map",
          desc: "Find all the closest grocery stores from you!",
          image: "assets/images/nearest_grocery_store.png",
          clickHint: "Let's go!",
          onClick: () async {
            String googleUrl =
                'https://www.google.com/maps/search/grocery+store/';
            await launchUrl(googleUrl);
          }),
      _Slide(
        title: "Fruits & veggies of the month",
        desc: "Discover seasonial product for your next recipe!",
        image: "assets/images/seasonial.png",
        clickHint: "Let's see",
        onClick: () => Get.toNamed(URL_SEASONIAL_INGREDIENTS),
      )
    ];

    return Container(
      height: 200,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 10000,
        duration: 500,
        itemCount: slides.length,
        outer: true,
        loop: true,
        pagination: getCustomSwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return CAcard(
            slide: slides[index],
          );
        },
      ),
    );
  }
}

class CAcard extends StatelessWidget {
  final _Slide slide;

  CAcard({@required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => slide.onClick(),
        child: Container(
          decoration: slide.image.isEmpty
              ? BoxDecoration()
              : BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: Image.asset(slide.image).image,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop)),
                  borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      slide.title.toUpperCase(),
                      style: textAssistantH1Accent,
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      slide.desc,
                      style: textAssistantH1WhiteBold,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Center(
                  child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        slide.clickHint,
                        style: textAssistantH2Accent,
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: accentColor,
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
