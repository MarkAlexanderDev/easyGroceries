import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/widgets_default/floating_action_button.dart';
import 'package:get/get.dart';

import '../urls.dart';

class CookingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FoodzFloatingActionButton(
        label: "Let's cook !",
        icon: Icons.whatshot,
        onPressed: () async {
          final RecipeStates recipeStates = Get.find();
          await recipeStates.readAllRecipes();
          recipeStates.recipe = recipeStates.allRecipes.first;
          Get.toNamed(URL_RECIPE_VIEW);
        });
  }
}
