import 'package:foodz/services/database/api.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_ingredient.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_step.dart';
import 'package:get/get.dart';

class RecipeStates extends GetxController {
  EntityRecipe recipe;
  RxList<EntityRecipe> recipeOwned = <EntityRecipe>[].obs;
  List<EntityRecipeIngredient> recipeIngredients = [];
  List<EntityRecipeStep> recipeSteps = [];
  EntityRecipeStep recipeStep;

  // CRUD

  Future<void> createRecipe() async {
    recipe.uid = await API.entries.recipe.create(recipe);
    recipeOwned.add(recipe);
  }

  Future<void> readRecipe(String recipeId) async {
    recipe = await API.entries.recipe.read(recipeId);
  }

  void updateRecipe() async {
    API.entries.recipe.update("", recipe);
  }

  void deleteRecipe(String uid) {
    API.entries.recipe.delete(uid);
  }

  // CRUD RecipeIngredients

  Future<void> createRecipeIngredient(EntityRecipeIngredient ingredient) async {
    await API.entries.recipe.ingredients.create(ingredient, key: recipe.uid);
  }

  void updateRecipeIngredient(EntityRecipeIngredient ingredient) async {
    API.entries.recipe.ingredients.update("", ingredient, key: recipe.uid);
  }

  void deleteRecipeIngredient(String ingredientName) {
    API.entries.recipe.ingredients.delete(ingredientName, key: recipe.uid);
  }

  // CRUD RecipeSteps

  Future<void> createRecipeStep(EntityRecipeStep step) async {
    await API.entries.recipe.steps.create(step, key: step.uid);
  }

  void updateRecipeStep(EntityRecipeStep step) async {
    API.entries.recipe.steps.update("", step, key: recipe.uid);
  }

  void deleteRecipeStep(String stepUid) {
    API.entries.recipe.ingredients.delete(stepUid, key: recipe.uid);
  }
}
