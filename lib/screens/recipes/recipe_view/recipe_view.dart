import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:foodz/screens/recipes/recipe_creation/recipe_creation.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/urls.dart';
import 'package:foodz/widgets_common/ingredient_item.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_common/step_item.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:get/get.dart';

class RecipeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipeView();
}

class _RecipeView extends State<RecipeView> {
  final RecipeStates recipeStates = Get.find();
  Future _futureRecipeData;

  Future<bool> _loader() async {
    await recipeStates.readAllIngredientsRecipe();
    await recipeStates.readAllStepsRecipe();
    recipeStates.recipeSteps.sort((a, b) => a.number.compareTo(b.number));
    return true;
  }

  @override
  void initState() {
    _futureRecipeData = _loader();
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
              recipeStates.recipe.name,
              style: textFredokaOneH1,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: mainColor, //change your color here
            ),
            actions: [
              GestureDetector(
                onTap: () => Get.toNamed(URL_RECIPE_CREATION, arguments: true),
                child: Icon(
                  Icons.edit,
                  color: mainColor,
                ),
              ),
              SizedBox(width: 15),
            ],
          )),
      body: FutureBuilder(
          future: _futureRecipeData,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData)
              return ListView(
                shrinkWrap: true,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: FoodzProfilePicture(
                      height: 150,
                      width: 150,
                      pictureUrl: recipeStates.recipe.pictureUrl.value,
                      editMode: false,
                      defaultChild: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset("assets/images/meal.png"),
                      ),
                    ),
                  ),
                  Text(
                    recipeStates.recipe.description,
                    style: textAssistantH1Black,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                      child: _Section(
                          placeHolder: SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: SpinBox(
                                min: 1,
                                max: 100,
                                value: recipeStates.recipe.peopleNumber.value
                                    .toDouble(),
                                onChanged: (double value) => recipeStates
                                    .recipe.peopleNumber.value = value.toInt()),
                          ),
                          label: "Serving"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                      child: _Section(
                          placeHolder: SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: AutoSizeText(
                              recipeStates.recipe.time.value
                                      .toString()
                                      .substring(
                                          0,
                                          recipeStates.recipe.time.value
                                              .toString()
                                              .lastIndexOf(":")) +
                                  "h",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          label: "Time"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 100,
                      child: _Section(
                          placeHolder: SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: AutoSizeText(
                                DIFFICULTY_LEVELS[
                                    recipeStates.recipe.difficulty.value],
                                style: textAssistantH3GreyBold,
                                textAlign: TextAlign.center),
                          ),
                          label: "Difficulty"),
                    ),
                  ]),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Ingredients",
                      style: textFredokaOneH2underlined,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeStates.recipeIngredients.length,
                      itemBuilder: (BuildContext context, int i) {
                        return IngredientItem(
                          name: recipeStates.recipeIngredients[i].name,
                          number:
                              recipeStates.recipeIngredients[i].number.value,
                          metric: recipeStates.recipeIngredients[i].metric,
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Instructions",
                      style: textFredokaOneH2underlined,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeStates.recipeSteps.length,
                      itemBuilder: (BuildContext context, int i) {
                        return StepItem(
                            number: recipeStates.recipeSteps[i].number,
                            text: recipeStates.recipeSteps[i].text,
                            onDelete: () {});
                      }),
                ],
              );
            else
              return FoodzLoading();
          }),
    );
  }
}

class _Section extends StatelessWidget {
  final Widget placeHolder;
  final String label;

  _Section({@required this.placeHolder, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AutoSizeText(
            label,
            style: textFredokaOneH3,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          placeHolder,
          Spacer(),
        ],
      ),
    );
  }
}
