import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_ingredient.dart';

EntityFridgeIngredient ingredientToFridgeIngredient(
    EntityIngredient ingredient) {
  return EntityFridgeIngredient(
    name: ingredient.title,
    category: ingredient.category,
    metric: ingredient.metric,
    pictureUrl: ingredient.pictureUrl,
  );
}

EntityGroceryListIngredient ingredientToGroceryListIngredient(
    EntityIngredient ingredient) {
  return EntityGroceryListIngredient(
    name: ingredient.title,
    category: ingredient.category,
    metric: ingredient.metric,
    pictureUrl: ingredient.pictureUrl,
  );
}

EntityRecipeIngredient ingredientToRecipeIngredient(
    EntityIngredient ingredient) {
  return EntityRecipeIngredient(
    name: ingredient.title,
    pictureUrl: ingredient.pictureUrl,
  );
}

EntityFridgeIngredient groceryListIngredientToFridgeIngredient(
    EntityGroceryListIngredient groceryListIngredient) {
  return EntityFridgeIngredient(
      pictureUrl: groceryListIngredient.pictureUrl,
      name: groceryListIngredient.name,
      metric: groceryListIngredient.metric,
      category: groceryListIngredient.category);
}
