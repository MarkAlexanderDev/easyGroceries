import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:get/get.dart';

class IngredientStates extends GetxController {
  RxList<EntityIngredient> ingredientFound = <EntityIngredient>[].obs;

  void search(String value) async {
    ingredientFound
        .assignAll(await API.configurations.ingredients.search(value));
    if (value != "") ingredientFound.insert(0, EntityIngredient(title: value));
  }
}
