import 'package:flutter/cupertino.dart';
import 'package:foodz/services/database/entities/fridge/entity_fridge_ingredient.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_ingredient.dart';
import 'package:foodz/utils/ingredient/data.dart';

Image getIngredientImageFromName(String name) {
  final List<EntityIngredient> ingredient =
      ingredientList.where((element) => element.title == name).toList();
  if (ingredient.isNotEmpty) return ingredient.first.image;
  return Image.asset("assets/images/ingredients/unknown.png");
}

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
  );
}

EntityGroceryListIngredient ingredientToGroceryListIngredient(
    EntityIngredient ingredient) {
  return EntityGroceryListIngredient(
      name: ingredient.title,
      category: ingredient.category,
      metric: ingredient.metric == null ? "" : ingredient.metric,
      number: getStepNumberFromMetric(ingredient.metric),
      checked: false);
}

EntityRecipeIngredient ingredientToRecipeIngredient(
    EntityIngredient ingredient) {
  return EntityRecipeIngredient(
    name: ingredient.title,
    number: getStepNumberFromMetric(ingredient.metric),
    metric: ingredient.metric == null ? "" : ingredient.metric,
  );
}

EntityFridgeIngredient groceryListIngredientToFridgeIngredient(
    EntityGroceryListIngredient groceryListIngredient) {
  return EntityFridgeIngredient(
      name: groceryListIngredient.name,
      metric: groceryListIngredient.metric,
      number: groceryListIngredient.number,
      category: groceryListIngredient.category);
}
