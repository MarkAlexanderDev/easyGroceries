import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/swiper_pagination_style.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/urlLauncher.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_default/button.dart';
import 'package:get/get.dart';

class ContextualArea extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> slides = [
      {
        "title": "foodz MAP",
        "desc": "Find all the closest grocery stores from you !",
        "image":
            "https://searchengineland.com/figz/wp-content/seloads/2014/08/map-local-search-ss-1920.jpg",
        "clickHint": "Let's go !",
        "onClick": () async {
          String googleUrl =
              'https://www.google.com/maps/search/grocery+store/';
          await launchUrl(googleUrl);
        }
      },
      {
        "title": "ingredient of the month",
        "desc": "It's asparagus season !",
        "image":
            "https://realandvibrant.com/wp-content/uploads/2019/10/Instant-Pot-Asparagus-2.jpg",
        "clickHint": "Add to list",
        "onClick": () {
          if (groceryListStates.groceryListOwned.isEmpty)
            Get.snackbar(
                "Oops", "You need to create at least one grocery list !");
          else {
            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      Container(
                        width: 20,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0))),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    FoodzProfilePicture(
                                      height: 100,
                                      width: 100,
                                      pictureUrl:
                                          "https://realandvibrant.com/wp-content/uploads/2019/10/Instant-Pot-Asparagus-2.jpg",
                                      editMode: false,
                                      defaultChild: Icon(
                                        Icons.add_shopping_cart_outlined,
                                        color: mainColor,
                                      ),
                                    ),
                                    Text(
                                      "Asparagus",
                                      style: textAssistantH1Black,
                                    ),
                                    SizedBox(height: 20),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: groceryListStates
                                          .groceryListOwned.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return FoodzButton(
                                          label: "Add to " +
                                              groceryListStates
                                                  .groceryListOwned[index]
                                                  .name
                                                  .value,
                                          onClick: () {
                                            groceryListStates.groceryList =
                                                groceryListStates
                                                    .groceryListOwned[index];
                                            groceryListStates
                                                .createGroceryListIngredient(
                                                    EntityGroceryListIngredient(
                                                        pictureUrl:
                                                            "https://realandvibrant.com/wp-content/uploads/2019/10/Instant-Pot-Asparagus-2.jpg",
                                                        name: "Asparagus",
                                                        metric: "g",
                                                        category: "Vegetables",
                                                        number: 100.0));
                                            Navigator.pop(context);
                                            Get.snackbar("Yay!",
                                                "The ingredient Asparagus has been added to your list !");
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  );
                });
          }
        }
      },
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
  final Map<String, dynamic> slide;

  CAcard({@required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: slide["onClick"],
        child: Container(
          decoration: slide["image"].isEmpty
              ? BoxDecoration()
              : BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(slide["image"]),
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
                      slide["title"].toString().toUpperCase(),
                      style: textAssistantH1Accent,
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      slide["desc"],
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
                        slide["clickHint"],
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
