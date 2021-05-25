import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/states/fridge_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/add_ingredient_bar.dart';
import 'package:foodz/widgets_common/bubble.dart';
import 'package:foodz/widgets_common/ingredient_item.dart';
import 'package:foodz/widgets_common/search_ingredient.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:get/get.dart';

class Fridge extends StatelessWidget {
  final FridgeStates fridgeStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          AutoSizeText(
            "Ingredients will automaticly be added here after buying groceries",
            style: textAssistantH3BlackBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          AddIngredientBar(
            searchModId: SEARCH_INGREDIENT_FOR_FRIDGE_ID,
            label: "Something's missing ? Click here to add a ingredient",
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(endpointFridges)
                  .doc(fridgeStates.fridge.uid)
                  .collection("Ingredients/")
                  .snapshots(),
              builder: (BuildContext streamContext, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text("No connection"),
                    );
                  case ConnectionState.waiting:
                    return Center(child: FoodzLoading());
                  case ConnectionState.active:
                    fridgeStates.fridgeIngredients =
                        _streamToFridgeIngredients(snapshot.data);
                    return SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: fridgeStates.fridgeIngredients.isEmpty
                          ? _EmptyFridge()
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: fridgeStates.fridgeIngredients.length,
                              itemBuilder: (BuildContext context, int i) {
                                return IngredientItem(
                                  name: fridgeStates.fridgeIngredients[i].name,
                                  pictureUrl: fridgeStates
                                      .fridgeIngredients[i].pictureUrl,
                                  number: fridgeStates
                                      .fridgeIngredients[i].number.value,
                                  metric:
                                      fridgeStates.fridgeIngredients[i].metric,
                                  onDelete: () => fridgeStates
                                      .deleteFridgeIngredient(fridgeStates
                                          .fridgeIngredients[i].name),
                                  onChangeQuantity: (double value) {
                                    fridgeStates.fridgeIngredients[i].number
                                        .value = value;
                                    fridgeStates.updateFridgeIngredient(
                                        fridgeStates.fridgeIngredients[i]);
                                  },
                                );
                              }),
                    ));
                  default:
                    return FoodzLoading();
                }
              }),
        ],
      ),
    );
  }

  List<EntityFridgeIngredient> _streamToFridgeIngredients(
      QuerySnapshot streamData) {
    return streamData.docs
        .map((e) => EntityFridgeIngredient.fromJson(e.data(), key: e.id))
        .toList();
  }
}

class _EmptyFridge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/sad_avocado.png",
              fit: BoxFit.contain,
              height: 75,
            ),
            Bubble(
              content: Row(
                children: [
                  AutoSizeText(
                    "Your fridge is empty.",
                    style: textAssistantH1WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
