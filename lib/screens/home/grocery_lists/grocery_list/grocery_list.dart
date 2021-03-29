import 'package:foodz/services/database/database.dart';
import 'package:foodz/services/database/models/grocery_list_ingredient_model.dart';
import 'package:foodz/services/database/models/grocery_list_model.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/utils/color.dart';
import 'package:foodz/widgets/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryList extends StatefulWidget {
  @override
  _GroceryList createState() => _GroceryList();
}

class _GroceryList extends State<GroceryList> {
  final GroceryListStates groceryListStates = Get.put(GroceryListStates());
  final GroceryListModel groceryList = Get.arguments;
  final SearchBarController _searchBarController = SearchBarController();
  Stream _stream;

  @override
  void initState() {
    groceryListStates.groceryList.value = groceryList;
    _stream = groceryListStates.streamGroceryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: StreamBuilder(
          stream: _stream,
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
                              onSearch: Database.ingredient.searchIngredient,
                              searchBarController: _searchBarController,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 2,
                              onError: (error) {
                                return Container();
                              },
                              onItemFound: (ingredient, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  )),
                                  child: ListTile(
                                    title: Text(ingredient["title"]),
                                    onTap: () async {
                                      groceryListStates
                                          .addIngredient(ingredient["title"]);
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
      int i, List<GroceryListIngredientModel> groceryListIngredients) {
    return GestureDetector(
      child: Row(
        children: [
          GestureDetector(
              onTap: () async {
                await groceryListStates.deleteIngredient(i);
              },
              child: Transform.rotate(
                  angle: 27.5,
                  child: Icon(Icons.add_circle_rounded, color: Colors.red))),
          Expanded(child: Container()),
          AutoSizeText(groceryListStates.groceryListIngredientsKeys[i]),
          Expanded(child: Container()),
          Checkbox(
            value: groceryListIngredients[i].checked,
            onChanged: (bool value) {
              groceryListStates.setIngredientCheckValue(value, i);
            },
          ),
        ],
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: hexToColor(groceryListStates.groceryList.value.color),
      title: AutoSizeText(
        groceryListStates.groceryList.value.title,
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
