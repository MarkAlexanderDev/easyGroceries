import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:get/get.dart';

class GroceryList extends StatefulWidget {
  @override
  _GroceryList createState() => _GroceryList();
}

class _GroceryList extends State<GroceryList> {
  final GroceryListStates groceryListStates = Get.find();
  Stream _streamGroceryListIngredients;

  @override
  void initState() {
    _streamGroceryListIngredients = API.entries.groceryList.ingredients
        .streamAll(key: groceryListStates.groceryList.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(URL_HOME);
        return false;
      },
      child: StreamBuilder(
          stream: _streamGroceryListIngredients,
          builder: (BuildContext streamContext, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  appBar: _getAppBar(context),
                  body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                          child: Column(
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
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int i) {
                                return _getGroceryListItem(i, snapshot.data);
                              }),
                          Container(
                            height: 150,
                          ),
                        ],
                      ))));
            } else
              return Loading();
          }),
    );
  }

  _getGroceryListItem(
      int i, List<EntityGroceryListIngredient> groceryListIngredients) {
    return GestureDetector(
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                groceryListStates.deleteGroceryListIngredient(
                    groceryListIngredients[i].name);
              },
              child: Transform.rotate(
                  angle: 27.5,
                  child: Icon(Icons.add_circle_rounded, color: Colors.red))),
          Expanded(child: Container()),
          AutoSizeText(groceryListIngredients[i].name),
          Expanded(child: Container()),
          Checkbox(
            value: groceryListIngredients[i].checked.value,
            onChanged: (bool value) {
              groceryListIngredients[i].checked.value = value;
            },
          ),
        ],
      ),
    );
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
        GestureDetector(
            onTap: () => {Get.toNamed(URL_GROCERY_LIST_OPTION)},
            child: Icon(Icons.create)),
        Container(width: 20),
      ],
      centerTitle: true,
    );
  }
}
