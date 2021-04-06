import 'package:auto_size_text/auto_size_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:get/get.dart';

class GroceryList extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());
  final SearchBarController _searchBarController = SearchBarController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: StreamBuilder(
          stream: groceryListStates.steamAllGroceryListIngredients(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  appBar: _getAppBar(),
                  body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount: groceryListStates
                                  .groceryListIngredients.length,
                              itemBuilder: (BuildContext context, int i) {
                                return _getGroceryListItem(i,
                                    groceryListStates.groceryListIngredients);
                              })),
                          Container(
                            height: 150,
                            child: SearchBar(
                              onSearch: API.configurations.ingredients.search,
                              searchBarController: _searchBarController,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 2,
                              onError: (error) {
                                return Container();
                              },
                              onItemFound:
                                  (EntityIngredient ingredient, int index) {
                                print("YEEEEEEEEEEEEEEEEES");
                                print(ingredient.title);
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: ListTile(
                                    title: Text(ingredient.title),
                                    onTap: () async {
                                      groceryListStates
                                          .createGroceryListIngredient(
                                              ingredient);
                                      _searchBarController.clear();
                                    },
                                  ),
                                );
                              },
                            ),
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
                    groceryListStates.groceryListIngredients[i].name);
              },
              child: Transform.rotate(
                  angle: 27.5,
                  child: Icon(Icons.add_circle_rounded, color: Colors.red))),
          Expanded(child: Container()),
          AutoSizeText(groceryListStates.groceryListIngredients[i].name),
          Expanded(child: Container()),
          Checkbox(
            value: groceryListStates.groceryListIngredients[i].checked.value,
            onChanged: (bool value) {
              groceryListStates.groceryListIngredients[i].checked.value = value;
            },
          ),
        ],
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: hexToColor(groceryListStates.groceryList.color.value),
      title: AutoSizeText(
        groceryListStates.groceryList.name.value,
        style: textStyleH3Bold,
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {Get.offNamed(URL_HOME)}),
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
