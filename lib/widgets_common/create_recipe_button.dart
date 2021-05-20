import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/states/app_states.dart';
import 'package:foodz/widgets_default/floating_action_button.dart';
import 'package:get/get.dart';

import '../urls.dart';

class CreateRecipeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: appStates.recipeIndex.value == 0,
          child: FoodzFloatingActionButton(
              label: "New recipe",
              icon: Icons.add_outlined,
              onPressed: () =>
                  Get.toNamed(URL_RECIPE_CREATION, arguments: false)),
        ));
  }
}
