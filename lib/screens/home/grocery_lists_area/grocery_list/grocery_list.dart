import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/config.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/states/fridge_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets_common/add_ingredient_bar.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_common/search_ingredient.dart';
import 'package:foodz/widgets_default/clear_button.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:foodz/widgets_default/pop_up_coming_soon.dart';
import 'package:get/get.dart';

class GroceryList extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(URL_HOME);
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
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text("No connection"),
                  );
                case ConnectionState.waiting:
                  return Center(child: FoodzLoading());
                case ConnectionState.active:
                  groceryListStates.groceryListIngredients =
                      _streamToGroceryListIngredients(snapshot.data);
                  return SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AddIngredientBar(
                          searchModId: SEARCH_INGREDIENT_FOR_GROCERY_LIST_ID,
                        ),
                        Container(height: 20),
                        _UncheckedItemsList(
                            groceryListIngredients:
                                groceryListStates.groceryListIngredients),
                        Container(
                          height: 25,
                        ),
                        _CheckedItemsList(
                            groceryListIngredients:
                                groceryListStates.groceryListIngredients),
                      ],
                    ),
                  ));
                default:
                  return FoodzLoading();
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
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: AutoSizeText(
        groceryListStates.groceryList.name.value,
        style: textFredokaOneH2,
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: mainColor, //change your color here
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.offNamed(URL_HOME)),
      actions: [
        GestureDetector(
            onTap: () => showPopUpComingSoon(context),
            child: Icon(Icons.add_shopping_cart)),
        SizedBox(width: 10),
        GestureDetector(
            onTap: () =>
                {Get.toNamed(URL_GROCERY_LIST_CREATION, arguments: true)},
            child: Icon(Icons.create)),
        SizedBox(width: 20),
      ],
    );
  }
}

class _UncheckedItemsList extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();
  final List<EntityGroceryListIngredient> groceryListIngredients;

  _UncheckedItemsList({@required this.groceryListIngredients});

  @override
  Widget build(BuildContext context) {
    final List<EntityGroceryListIngredient> groceryListIngredientsUnchecked =
        groceryListIngredients
            .where(
                (EntityGroceryListIngredient element) => !element.checked.value)
            .toList();
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: groceryListIngredientsUnchecked.length,
        itemBuilder: (BuildContext context, int i) {
          return _GroceryListIngredientWidget(
            groceryListIngredient: groceryListIngredientsUnchecked[i],
            onChecked: (bool value) {
              groceryListIngredientsUnchecked[i].checked.value = value;
              groceryListStates.updateGroceryListIngredient(
                  groceryListIngredientsUnchecked[i]);
            },
          );
        });
  }
}

class _CheckedItemsList extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();
  final FridgeStates fridgeStates = Get.find();
  final List<EntityGroceryListIngredient> groceryListIngredients;

  _CheckedItemsList({@required this.groceryListIngredients});

  @override
  Widget build(BuildContext context) {
    final List<EntityGroceryListIngredient> groceryListIngredientsChecked =
        groceryListIngredients
            .where(
                (EntityGroceryListIngredient element) => element.checked.value)
            .toList();
    return Column(
      children: [
        Visibility(
          visible: groceryListIngredientsChecked.length > 0,
          child: Row(
            children: [
              AutoSizeText("Checked items", style: textAssistantH2BlackBold),
              Spacer(),
              FoodzClearButton(
                  label: "Clear and add to my fridge",
                  onClick: () {
                    groceryListIngredientsChecked.forEach(
                      (EntityGroceryListIngredient element) {
                        fridgeStates.createFridgeIngredient(
                            EntityFridgeIngredient(
                                pictureUrl: element.pictureUrl,
                                name: element.name,
                                metric: element.metric.value,
                                category: element.category));
                        groceryListStates
                            .deleteGroceryListIngredient(element.name);
                      },
                    );
                  })
            ],
          ),
        ),
        Container(
          height: 15,
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: groceryListIngredientsChecked.length,
            itemBuilder: (BuildContext context, int i) {
              return _GroceryListIngredientWidget(
                groceryListIngredient: groceryListIngredientsChecked[i],
                onChecked: (bool value) {
                  groceryListIngredientsChecked[i].checked.value = value;
                  groceryListStates.updateGroceryListIngredient(
                      groceryListIngredientsChecked[i]);
                },
              );
            }),
      ],
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
              Opacity(
                opacity: groceryListIngredient.checked.value ? 0.3 : 1.0,
                child: FoodzProfilePicture(
                  height: 50,
                  width: 50,
                  pictureUrl: groceryListIngredient.pictureUrl,
                  editMode: false,
                  defaultChild: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: mainColor,
                  ),
                ),
              ),
              Expanded(child: Container()),
              AutoSizeText(groceryListIngredient.name,
                  style: textAssistantH2BlackBold.copyWith(
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
      ),
    );
  }
}
