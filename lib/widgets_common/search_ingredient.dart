import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/fridge_states.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/states/ingredient_states.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/ingredient/ingredient.dart';
import 'package:foodz/widgets_common/ingredient_picture.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

const int SEARCH_INGREDIENT_FOR_GROCERY_LIST_ID = 0;
const int SEARCH_INGREDIENT_FOR_FRIDGE_ID = 1;
const int SEARCH_INGREDIENT_FOR_RECIPE_ID = 2;

class SearchIngredient extends StatelessWidget {
  final GroceryListStates groceryListStates = Get.find();
  final FridgeStates fridgeStates = Get.find();
  final RecipeStates recipeStates = Get.find();
  final IngredientStates ingredientStates = Get.find();

  final int searchModId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Container(),
        actions: [
          SizedBox(width: 10),
          Expanded(
            child: FoodzTextInput(
              autofocus: true,
              textAlignCenter: false,
              initialValue: "",
              hint: "Ex: Banana, Apple, ect ...",
              onChanged: (String value) {
                ingredientStates.search(value);
              },
              onClear: () {
                ingredientStates.ingredientFound.clear();
              },
            ),
          ),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: GestureDetector(
              onTap: () => Get.back(),
              child: AutoSizeText(
                "Done",
                style: textFredokaOneH3,
              ),
            )),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: ingredientStates.ingredientFound.length,
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              onTap: () {
                _addItem(i);
                ingredientStates.ingredientFound.clear();
                Get.back();
              },
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.center,
                  child: FoodzIngredientPicture(
                    height: 50,
                    width: 50,
                    image: ingredientStates.ingredientFound[i].image,
                  ),
                ),
                title: Text(ingredientStates.ingredientFound[i].title),
                dense: false,
              ),
            );
          })),
    );
  }

  void _addItem(int i) {
    switch (searchModId) {
      case SEARCH_INGREDIENT_FOR_GROCERY_LIST_ID:
        groceryListStates.createGroceryListIngredient(
            ingredientToGroceryListIngredient(
                ingredientStates.ingredientFound[i]));
        break;
      case SEARCH_INGREDIENT_FOR_FRIDGE_ID:
        fridgeStates.createFridgeIngredient(
            ingredientToFridgeIngredient(ingredientStates.ingredientFound[i]));
        break;
      case SEARCH_INGREDIENT_FOR_RECIPE_ID:
        recipeStates.recipeIngredients.add(
            ingredientToRecipeIngredient(ingredientStates.ingredientFound[i]));
        break;
      default:
        break;
    }
  }
}
