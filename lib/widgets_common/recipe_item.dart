import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/recipes/recipe_creation/recipe_creation.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_common/rater.dart';
import 'package:get/get.dart';

class RecipeItem extends StatelessWidget {
  final EntityRecipe recipe;

  RecipeItem({@required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          final RecipeStates recipeStates = Get.find();
          recipeStates.recipe = recipe;
          Get.toNamed(URL_RECIPE_VIEW);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.05),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FoodzProfilePicture(
                  height: 50,
                  width: 50,
                  pictureUrl: recipe.pictureUrl.value,
                  editMode: false,
                  defaultChild: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset("assets/images/meal.png"),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(recipe.name, style: textAssistantH2BlackBold),
                    AutoSizeText(recipe.description,
                        style: textAssistantH3GreyBold),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(width: 3),
                        AutoSizeText(
                            recipe.time.value.substring(0,
                                recipe.time.value.toString().lastIndexOf(":")),
                            style: textAssistantH3GreyBold),
                        SizedBox(width: 15),
                        Icon(
                          Icons.whatshot,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(width: 3),
                        AutoSizeText(DIFFICULTY_LEVELS[recipe.difficulty.value],
                            style: textAssistantH3GreyBold),
                      ],
                    )
                  ],
                ),
                Spacer(),
                Rater(
                  currentGrade: recipe.grade.value,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
