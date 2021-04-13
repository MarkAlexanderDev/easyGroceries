import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:foodz/widgets/profile_picture.dart';
import 'package:get/get.dart';

class GroceryList extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(URL_HOME);
        return false;
      },
      child: Scaffold(
        appBar: _getAppBar(context),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(endpointGroceryLists)
                .doc(groceryListStates.groceryList.uid)
                .collection("Ingredients/")
                .snapshots(),
            builder: (BuildContext streamContext, AsyncSnapshot snapshot) {
              if (snapshot.hasError)
                return Center(
                    child: Text("Error: " + snapshot.error.toString()));
              else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text("No connection"),
                    );
                  case ConnectionState.waiting:
                    return Center(child: Loading());
                  case ConnectionState.active:
                    final List<EntityGroceryListIngredient>
                        groceryListIngredients =
                        _streamToGroceryListIngredients(snapshot.data);
                    final List<EntityGroceryListIngredient>
                        groceryListIngredientsChecked = groceryListIngredients
                            .where((EntityGroceryListIngredient element) =>
                                element.checked.value)
                            .toList();
                    final List<EntityGroceryListIngredient>
                        groceryListIngredientsUnchecked = groceryListIngredients
                            .where((EntityGroceryListIngredient element) =>
                                !element.checked.value)
                            .toList();
                    return SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Get.toNamed(URL_GROCERY_LIST_SEARCH_INGREDIENT),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    AutoSizeText(
                                        "Click here to add an ingredient",
                                        style: TextStyle(color: Colors.green)),
                                    Expanded(child: Container()),
                                    Icon(
                                      Icons.add,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(height: 20),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: groceryListIngredientsUnchecked.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Column(
                                  children: [
                                    _GroceryListIngredientWidget(
                                      groceryListIngredient:
                                          groceryListIngredientsUnchecked[i],
                                      onChecked: (bool value) {
                                        groceryListIngredientsUnchecked[i]
                                            .checked
                                            .value = value;
                                        groceryListStates
                                            .updateGroceryListIngredient(
                                                groceryListIngredientsUnchecked[
                                                    i]);
                                      },
                                    ),
                                    Container(
                                      height: 2.5,
                                    )
                                  ],
                                );
                              }),
                          Container(
                            height: 25,
                          ),
                          Row(
                            children: [
                              AutoSizeText("Checked items"),
                              Expanded(child: Container()),
                              GestureDetector(
                                  onTap: () {
                                    groceryListIngredientsChecked.forEach(
                                        (EntityGroceryListIngredient element) {
                                      groceryListStates
                                          .deleteGroceryListIngredient(
                                              element.name);
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                          Container(
                            height: 15,
                          ),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: groceryListIngredientsChecked.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Column(
                                  children: [
                                    _GroceryListIngredientWidget(
                                      groceryListIngredient:
                                          groceryListIngredientsChecked[i],
                                      onChecked: (bool value) {
                                        groceryListIngredientsChecked[i]
                                            .checked
                                            .value = value;
                                        groceryListStates
                                            .updateGroceryListIngredient(
                                                groceryListIngredientsChecked[
                                                    i]);
                                      },
                                    ),
                                    Container(
                                      height: 10,
                                    )
                                  ],
                                );
                              }),
                        ],
                      ),
                    ));
                  default:
                    return Loading();
                }
              }
            }),
      ),
    );
  }

  List<EntityGroceryListIngredient> _streamToGroceryListIngredients(
      QuerySnapshot streamData) {
    return streamData.docs
        .map((e) => EntityGroceryListIngredient.fromJson(e.data(), key: e.id))
        .toList();
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: hexToColor(groceryListStates.groceryList.color.value),
      title: AutoSizeText(
        groceryListStates.groceryList.name.value,
        style: textStyleH3Bold,
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Get.toNamed(URL_HOME)}),
      actions: [
        GestureDetector(onTap: () {}, child: Icon(Icons.add_shopping_cart)),
        Container(width: 20),
        GestureDetector(
            onTap: () => {Get.toNamed(URL_GROCERY_LIST_OPTION)},
            child: Icon(Icons.create)),
        Container(width: 20),
      ],
      centerTitle: true,
    );
  }
}

class _GroceryListIngredientWidget extends StatelessWidget {
  final EntityGroceryListIngredient groceryListIngredient;
  final onChecked;

  _GroceryListIngredientWidget(
      {@required this.groceryListIngredient, @required this.onChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.05),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ProfilePicture(
                height: 50,
                width: 50,
                pictureUrl: groceryListIngredient.pictureUrl,
                editMode: false),
            Expanded(child: Container()),
            AutoSizeText(groceryListIngredient.name,
                style: TextStyle(
                    decoration: groceryListIngredient.checked.value
                        ? TextDecoration.lineThrough
                        : TextDecoration.none)),
            Expanded(child: Container()),
            Checkbox(
              checkColor: Colors.white,
              activeColor: mainColor,
              value: groceryListIngredient.checked.value,
              onChanged: onChecked,
            ),
          ],
        ),
      ),
    );
  }
}
