import 'package:flutter/cupertino.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:foodz/utils/ingredient/data.dart';
import 'package:get/get.dart';

class IngredientStates extends GetxController {
  RxList<EntityIngredient> ingredientFound = <EntityIngredient>[].obs;

  void search(String value) {
    ingredientFound.assignAll(ingredientList.where((element) =>
        element.title.startsWith(value) ||
        element.title.startsWith(value.capitalize)));
    if (value != "")
      ingredientFound.insert(
          0,
          EntityIngredient(
              title: value,
              image: Image.asset("assets/images/ingredients/unknown.png"),
              allergies: [],
              category: "",
              metric: "",
              seasons: []));
  }
}
