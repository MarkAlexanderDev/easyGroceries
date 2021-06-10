import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/home/grocery_lists_area/grocery_lists_item.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/ingredient/data.dart';
import 'package:foodz/utils/ingredient/ingredient.dart';
import 'package:foodz/widgets_common/ingredient_picture.dart';
import 'package:get/get.dart';

import '../../../urls.dart';

class SeasonialIngredients extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<EntityIngredient> seasonialIngredients = ingredientList
        .where((element) => element.seasons.contains(DateTime.now().month))
        .toList();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Seasonial fruits & veggies",
            style: textFredokaOneH2,
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: mainColor, //change your color here
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.offNamed(URL_HOME)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: seasonialIngredients.length,
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _modalBottomSheetMenu(
                          context, seasonialIngredients[i]),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: 75,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: grey, width: 0.25),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FoodzIngredientPicture(
                                height: 50,
                                width: 50,
                                image: seasonialIngredients[i].image,
                              ),
                            ),
                            Spacer(),
                            Text(
                              seasonialIngredients[i].title,
                              style: textAssistantH1Black,
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.add_outlined,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
        ));
  }

  void _modalBottomSheetMenu(
      BuildContext context, EntityIngredient ingredient) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                width: 20,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
              SizedBox(height: 10),
              Container(
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
                          FoodzIngredientPicture(
                            height: 100,
                            width: 100,
                            image: ingredient.image,
                          ),
                          SizedBox(height: 20),
                          Text(
                            ingredient.title,
                            style: textAssistantH1Black,
                          ),
                          SizedBox(height: 20),
                          groceryListStates.groceryListOwned.isEmpty
                              ? _NoGroceryList()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      groceryListStates.groceryListOwned.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return GroceryListsItem(
                                        onTap: () {
                                          groceryListStates.groceryList =
                                              groceryListStates
                                                  .groceryListOwned[i];
                                          groceryListStates
                                              .createGroceryListIngredient(
                                                  ingredientToGroceryListIngredient(
                                                      ingredient));
                                          Navigator.pop(context);
                                          Get.snackbar(
                                              "Wouhou!",
                                              ingredient.title +
                                                  " has been added to " +
                                                  groceryListStates
                                                      .groceryList.name.value);
                                        },
                                        groceryList: groceryListStates
                                            .groceryListOwned[i]);
                                  },
                                )
                        ],
                      ),
                    ),
                  )),
            ],
          );
        });
  }

  String _formatMonthsList(List<int> seasons) {
    final List<String> monthsString = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    String formatedString = "";
    for (int i = 0; i < seasons.length; i++) {
      formatedString += monthsString[seasons[i]];
      if (i != seasons.length - 1) formatedString += "/";
    }
    return formatedString;
  }
}

class _NoGroceryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("You don't have any grocery list", style: textFredokaOneH3),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset("assets/images/sad_avocado.png", height: 100),
        )
      ],
    );
  }
}
