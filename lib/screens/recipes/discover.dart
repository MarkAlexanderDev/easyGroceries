import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/recipe_states.dart';
import 'package:foodz/widgets_common/recipe_item.dart';
import 'package:foodz/widgets_default/loading.dart';
import 'package:get/get.dart';

class Discover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Discover();
}

class _Discover extends State<Discover> {
  final RecipeStates recipeStates = Get.find();
  Future _futureAllRecipes;

  @override
  void initState() {
    _futureAllRecipes = recipeStates.readAllRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureAllRecipes,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
                shrinkWrap: true,
                itemCount: recipeStates.allRecipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeItem(recipe: recipeStates.allRecipes[index]);
                });
          else
            return FoodzLoading();
        });
  }
}
