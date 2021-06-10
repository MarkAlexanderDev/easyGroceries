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
import 'package:foodz/widgets_common/bubble.dart';
import 'package:foodz/widgets_common/ingredient_item.dart';
import 'package:foodz/widgets_common/search_ingredient.dart';
import 'package:foodz/widgets_default/clear_button.dart';
import 'package:foodz/widgets_default/floating_action_button.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:foodz/widgets_default/pop_up_coming_soon.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
                          groceryListStates.groceryListIngredients.isEmpty
                              ? _EmptyGroceryList()
                              : Container(),
                          _UncheckedItemsList(),
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
          floatingActionButton: FoodzFloatingActionButton(
            label: "Order groceries",
            icon: Icons.add_shopping_cart,
            onPressed: () => showPopUpComingSoon(context),
          )),
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
            onTap: () =>
                {Get.toNamed(URL_GROCERY_LIST_CREATION, arguments: true)},
            child: Icon(Icons.create)),
        SizedBox(width: 20),
      ],
    );
  }
}

class _UncheckedItemsList extends StatefulWidget {
  @override
  __UncheckedItemsList createState() => __UncheckedItemsList();
}

class __UncheckedItemsList extends State<_UncheckedItemsList>
    with SingleTickerProviderStateMixin {
  final GroceryListStates groceryListStates = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<EntityGroceryListIngredient> groceryListIngredientsUnchecked =
        groceryListStates.groceryListIngredients
            .where(
                (EntityGroceryListIngredient element) => !element.checked.value)
            .toList();
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: groceryListIngredientsUnchecked.length,
        itemBuilder: (BuildContext context, int i) {
          return Obx(() => IngredientItem(
                name: groceryListIngredientsUnchecked[i].name,
                number: groceryListIngredientsUnchecked[i].number.value,
                metric: groceryListIngredientsUnchecked[i].metric,
                checkable: true,
                checked: groceryListIngredientsUnchecked[i].checked.value,
                onChecked: (bool value) {
                  groceryListIngredientsUnchecked[i].checked.value = value;
                },
                onDelete: () => groceryListStates.deleteGroceryListIngredient(
                    groceryListIngredientsUnchecked[i].name),
                onChangeQuantity: (double value) {
                  groceryListIngredientsUnchecked[i].number.value = value;
                  groceryListStates.updateGroceryListIngredient(
                      groceryListIngredientsUnchecked[i]);
                },
              ));
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
              FoodzClearButton(onClick: () {
                groceryListIngredientsChecked.forEach(
                  (EntityGroceryListIngredient element) {
                    fridgeStates.createFridgeIngredient(EntityFridgeIngredient(
                        name: element.name,
                        number: element.number.value,
                        metric: element.metric,
                        category: element.category));
                    groceryListStates.deleteGroceryListIngredient(element.name);
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
              return Obx(() => IngredientItem(
                    name: groceryListIngredientsChecked[i].name,
                    number: groceryListIngredientsChecked[i].number.value,
                    metric: groceryListIngredientsChecked[i].metric,
                    checkable: true,
                    checked: groceryListIngredientsChecked[i].checked.value,
                    onChecked: (bool value) =>
                        groceryListIngredientsChecked[i].checked.value = value,
                    onDelete: () =>
                        groceryListStates.deleteGroceryListIngredient(
                            groceryListIngredientsChecked[i].name),
                    onChangeQuantity: (double value) {
                      groceryListIngredientsChecked[i].number.value = value;
                      groceryListStates.updateGroceryListIngredient(
                          groceryListIngredientsChecked[i]);
                    },
                  ));
            }),
      ],
    );
  }
}

class _EmptyGroceryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/happy_avocado.png",
              fit: BoxFit.contain,
              height: 75,
            ),
            Bubble(
              content: Row(
                children: [
                  AutoSizeText(
                    "Your list is empty,\nadd new ingredients.",
                    style: textAssistantH1WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Lottie.asset("assets/lotties/arrow_down.json",
                        height: 50, fit: BoxFit.fitHeight),
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
