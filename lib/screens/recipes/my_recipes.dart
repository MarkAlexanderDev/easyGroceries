import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/bubble.dart';
import 'package:foodz/widgets_common/recipe_item.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MyRecipes extends StatelessWidget {
  final RecipeStates recipeStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return recipeStates.recipeOwned.isEmpty
        ? _EmptyMyRecipes()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: recipeStates.recipeOwned.length,
            itemBuilder: (BuildContext context, int index) {
              return RecipeItem(recipe: recipeStates.recipeOwned[index]);
            });
  }
}

class _EmptyMyRecipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/joyful_avocado.png",
              fit: BoxFit.contain,
              height: 75,
            ),
            Bubble(
              content: Column(
                children: [
                  AutoSizeText(
                    "Share your cooking skills\nwith the foodz community",
                    style: textAssistantH1WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Lottie.asset("assets/lotties/arrow_down.json",
                      height: 50, fit: BoxFit.fitHeight),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
