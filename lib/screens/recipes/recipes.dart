import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/screens/recipes/discover.dart';
import 'package:foodz/screens/recipes/my_recipes.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/widgets_default/toogle_button.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Recipes extends StatefulWidget {
  @override
  _Recipes createState() => _Recipes();
}

class _Recipes extends State<Recipes> {
  final List<Widget> screens = [
    MyRecipes(),
    //Favorites(),
    Discover(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Center(
                child: Obx(() => FoodzToogleButton(
                    items: ["My recipes", /*"Favorites",*/ "Discover"],
                    onPressed: (int index) {
                      appStates.recipeIndex.value = index;
                    },
                    selectedItem: appStates.recipeIndex.value))),
            SizedBox(height: 25),
            Obx(() => screens[appStates.recipeIndex.value]),
          ],
        ));
  }
}
