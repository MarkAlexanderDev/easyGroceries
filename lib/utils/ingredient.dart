import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_ingredient.dart';

double getStepNumberFromMetric(String metric) {
  switch (metric) {
    case "g":
      return 50;
    case "ml":
      return 50;
    default:
      return 1.0;
  }
}

EntityFridgeIngredient ingredientToFridgeIngredient(
    EntityIngredient ingredient) {
  return EntityFridgeIngredient(
    name: ingredient.title,
    category: ingredient.category,
    number: getStepNumberFromMetric(ingredient.metric),
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
    number: getStepNumberFromMetric(ingredient.metric),
  );
}

EntityRecipeIngredient ingredientToRecipeIngredient(
    EntityIngredient ingredient) {
  return EntityRecipeIngredient(
    name: ingredient.title,
    pictureUrl: ingredient.pictureUrl,
    number: getStepNumberFromMetric(ingredient.metric),
    metric: ingredient.metric == null ? "" : ingredient.metric,
  );
}

EntityFridgeIngredient groceryListIngredientToFridgeIngredient(
    EntityGroceryListIngredient groceryListIngredient) {
  return EntityFridgeIngredient(
      pictureUrl: groceryListIngredient.pictureUrl,
      name: groceryListIngredient.name,
      metric: groceryListIngredient.metric,
      number: groceryListIngredient.number,
      category: groceryListIngredient.category);
}
