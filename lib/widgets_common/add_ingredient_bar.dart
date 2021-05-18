import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:get/get.dart';

import '../urls.dart';

class AddIngredientBar extends StatelessWidget {
  final String label;

  AddIngredientBar({this.label = "Click here to add an ingredient"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(URL_GROCERY_LIST_SEARCH_INGREDIENT),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: Colors.green, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              AutoSizeText(label, style: textAssistantH3BlackBold.copyWith(color: Colors.green)),
              Expanded(child: Container()),
              Icon(
                Icons.add,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
