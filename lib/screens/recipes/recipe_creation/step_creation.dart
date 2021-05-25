import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_step.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

class StepCreation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StepCreation();
}

class _StepCreation extends State<StepCreation> {
  final RecipeStates recipeStates = Get.find();

  @override
  void initState() {
    recipeStates.recipeStep =
        EntityRecipeStep(number: recipeStates.recipeSteps.length + 1, text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(0, 60),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: AutoSizeText(
              "Instruction #" + recipeStates.recipeStep.number.toString(),
              style: textFredokaOneH1,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: mainColor, //change your color here
            ),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FoodzTextInput(
              multiline: true,
              autofocus: true,
              textAlignCenter: false,
              initialValue: recipeStates.recipeStep.text,
              hint: "Ex: Preheat oven to 350°F (175°C).",
              onChanged: (String value) {
                recipeStates.recipeStep.text = value;
              },
              onClear: () {},
              height: MediaQuery.of(context).size.height / 2,
            ),
          ),
          GestureDetector(
            onTap: () {
              recipeStates.recipeSteps.add(recipeStates.recipeStep);
              FocusScope.of(context).unfocus();
              Get.back();
            },
            child: AutoSizeText(
              "Done",
              style: textFredokaOneH3,
            ),
          )
        ],
      ),
    );
  }
}
