import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_ingredient.dart';
import 'package:foodz/services/database/entities/recipe/entity_recipe_step.dart';
import 'package:foodz/states/account_states.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/date.dart';
import 'package:foodz/utils/picture.dart';
import 'package:foodz/widgets_common/add_ingredient_bar.dart';
import 'package:foodz/widgets_common/add_step_bar.dart';
import 'package:foodz/widgets_common/ingredient_item.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_common/search_ingredient.dart';
import 'package:foodz/widgets_common/step_item.dart';
import 'package:foodz/widgets_default/confirm_button.dart';
import 'package:foodz/widgets_default/dropdown_button.dart';
import 'package:foodz/widgets_default/duration_picker.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

const List<String> DIFFICULTY_LEVELS = ["Easy", "Medium", "Hard"];

class RecipeCreation extends StatefulWidget {
  @override
  _RecipeCreation createState() => _RecipeCreation();
}

class _RecipeCreation extends State<RecipeCreation> {
  final RecipeStates recipeStates = Get.find();
  final AccountStates accountStates = Get.find();
  final bool isEditing = Get.arguments;

  @override
  void initState() {
    if (!isEditing) {
      recipeStates.recipe = EntityRecipe();
      recipeStates.recipe.createdBy = accountStates.account.uid;
      recipeStates.recipe.peopleNumber.value =
          accountStates.account.peopleNb.value;
      recipeStates.recipe.name = "";
      recipeStates.recipe.description = "";
      recipeStates.recipeIngredients.clear();
      recipeStates.recipeSteps.clear();
    }
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
              "Recipe creation",
              style: textFredokaOneH1,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: mainColor, //change your color here
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GestureDetector(
              onTap: () async {
                recipeStates.recipe.pictureUrl.value = await getImage(
                    context, recipeStates.recipe.pictureUrl.value != null);
              },
              child: Align(
                alignment: Alignment.center,
                child: Obx(() => FoodzProfilePicture(
                      pictureUrl: recipeStates.recipe.pictureUrl.value,
                      editMode: true,
                      height: 100,
                      width: 100,
                      defaultChild: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset("assets/images/meal.png"),
                      ),
                      onEdit: () async {
                        recipeStates.recipe.pictureUrl.value = await getImage(
                            context,
                            recipeStates.recipe.pictureUrl.value != null);
                      },
                    )),
              ),
            ),
            SizedBox(height: 30),
            FoodzTextInput(
              hint: "Recipe name",
              initialValue: recipeStates.recipe.name,
              onChanged: (value) {
                recipeStates.recipe.name = value;
              },
              onClear: () {
                recipeStates.recipe.name = "";
              },
            ),
            SizedBox(height: 30),
            FoodzTextInput(
              hint: "Description",
              initialValue: recipeStates.recipe.description,
              onChanged: (value) {
                recipeStates.recipe.description = value;
              },
              onClear: () {
                recipeStates.recipe.description = "";
              },
            ),
            SizedBox(height: 30),
            _Section(
                placeHolder: Obx(() => FoodzDropdownButton(
                      currentValue: DIFFICULTY_LEVELS[
                          recipeStates.recipe.difficulty.value],
                      items: DIFFICULTY_LEVELS,
                      onChanged: (String value) => recipeStates.recipe
                          .difficulty.value = DIFFICULTY_LEVELS.indexOf(value),
                    )),
                label: "Difficulty",
                description:
                    "How difficult do you consirate this recipe to be ?"),
            SizedBox(height: 30),
            _Section(
                placeHolder: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: SpinBox(
                      min: 1,
                      max: 100,
                      value: recipeStates.recipe.peopleNumber.value.toDouble(),
                      onChanged: (double value) => recipeStates
                          .recipe.peopleNumber.value = value.toInt()),
                ),
                label: "Serving",
                description:
                    "This is used to scale the recipe and calculate nutrition per serving"),
            SizedBox(height: 30),
            _Section(
                placeHolder: Obx(() => FoodzDurationPicker(
                      duration: recipeStates.recipe.time.value.isEmpty
                          ? Duration()
                          : parseDuration(recipeStates.recipe.time.value),
                      onDurationSelected: (Duration duration) {
                        parseDuration(duration.toString());
                        recipeStates.recipe.time.value = duration.toString();
                      },
                    )),
                label: "Cook time",
                description: "How long does it take to cook this recipe ?"),
            SizedBox(height: 30),
            AddIngredientBar(
              searchModId: SEARCH_INGREDIENT_FOR_RECIPE_ID,
            ),
            SizedBox(height: 15),
            Obx(() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipeStates.recipeIngredients.length,
                itemBuilder: (BuildContext context, int i) {
                  return Obx(() => IngredientItem(
                        name: recipeStates.recipeIngredients[i].name,
                        number: recipeStates.recipeIngredients[i].number.value,
                        metric: recipeStates.recipeIngredients[i].metric,
                        onDelete: () {
                          recipeStates.recipeIngredients.removeAt(i);
                        },
                        onChangeQuantity: (double value) {
                          recipeStates.recipeIngredients[i].number.value =
                              value;
                        },
                      ));
                })),
            SizedBox(height: 30),
            AddStepBar(),
            SizedBox(height: 15),
            Obx(() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipeStates.recipeSteps.length,
                itemBuilder: (BuildContext context, int i) {
                  return StepItem(
                    number: recipeStates.recipeSteps[i].number,
                    text: recipeStates.recipeSteps[i].text,
                    onDelete: () {
                      recipeStates.recipeSteps.removeAt(i);
                    },
                  );
                })),
            SizedBox(height: 10),
          ]),
        ),
      ),
      bottomNavigationBar: FoodzConfirmButton(
          label: "confirm my recipe",
          enabled: true,
          onClick: () async {
            appStates.setLoading(true);
            if (isEditing)
              recipeStates.updateRecipe();
            else {
              await recipeStates.createRecipe();
              await Future.forEach(recipeStates.recipeIngredients,
                  (EntityRecipeIngredient element) async {
                await recipeStates.createRecipeIngredient(element);
              });
              await Future.forEach(recipeStates.recipeSteps,
                  (EntityRecipeStep element) async {
                await recipeStates.createRecipeStep(element);
              });
              accountStates.account.recipeIds.add(recipeStates.recipe.uid);
              accountStates
                  .updateAccount(FirebaseAuth.instance.currentUser.uid);
            }
            Get.back();
            appStates.setLoading(false);
          }),
    );
  }
}

class _Section extends StatelessWidget {
  final Widget placeHolder;
  final String label;
  final String description;

  _Section(
      {@required this.placeHolder,
      @required this.label,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(label, style: textFredokaOneH3),
              AutoSizeText(
                description,
                style: textAssistantH2BlackBold,
              ),
            ],
          ),
        ),
        Spacer(),
        placeHolder,
      ],
    );
  }
}
