import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/states/fridge_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/add_ingredient_bar.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
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
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: fridgeStates.fridgeIngredients.length,
                          itemBuilder: (BuildContext context, int i) {
                            return _FridgeIngredientWidget(
                              fridgeIngredient:
                                  fridgeStates.fridgeIngredients[i],
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

class _FridgeIngredientWidget extends StatelessWidget {
  final EntityFridgeIngredient fridgeIngredient;

  _FridgeIngredientWidget({@required this.fridgeIngredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.05),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FoodzProfilePicture(
                height: 50,
                width: 50,
                pictureUrl: fridgeIngredient.pictureUrl,
                editMode: false,
                defaultChild: Icon(
                  Icons.add_shopping_cart_outlined,
                  color: mainColor,
                ),
              ),
              Expanded(child: Container()),
              AutoSizeText(fridgeIngredient.name,
                  style: textAssistantH2BlackBold),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
