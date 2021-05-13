import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/states/ingredient_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:get/get.dart';

class GroceryListSearchIngredient extends StatefulWidget {
  @override
  _GroceryListSearchIngredient createState() => _GroceryListSearchIngredient();
}

class _GroceryListSearchIngredient extends State<GroceryListSearchIngredient> {
  final GroceryListStates groceryListStates = Get.find();
  final IngredientStates ingredientStates = Get.find();
  final TextEditingController _controller = TextEditingController();
  SearchBar searchBar;

  AppBar buildAppBar(BuildContext appBarCtx) {
    FocusScope.of(appBarCtx).requestFocus(FocusNode());
    return AppBar(
      backgroundColor: mainColor,
      leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: () => {Get.back()}),
      actions: [searchBar.getSearchAction(appBarCtx)],
      centerTitle: true,
    );
  }

  @override
  void initState() {
    searchBar = SearchBar(
        onChanged: (String value) {
          ingredientStates.search(value);
        },
        onClosed: () {
          ingredientStates.ingredientFound.clear();
        },
        clearOnSubmit: true,
        inBar: false,
        setState: setState,
        buildDefaultAppBar: buildAppBar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: ingredientStates.ingredientFound.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: () {
                groceryListStates.createGroceryListIngredient(
                    ingredientStates.ingredientFound[i]);
                Get.back();
              },
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.center,
                  child: FoodzProfilePicture(
                    height: 50,
                    width: 50,
                    editMode: false,
                    pictureUrl: ingredientStates.ingredientFound[i].pictureUrl,
                  ),
                ),
                title: Text(ingredientStates.ingredientFound[i].title),
                dense: false,
              ),
            );
          })),
    );
  }
}
