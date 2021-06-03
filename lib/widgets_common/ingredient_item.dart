import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:foodz/services/database/entities/grocery_list/entity_grocery_list_ingredient.dart';
import 'package:foodz/states/grocery_list_states.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/ingredient/ingredient.dart';
import 'package:foodz/widgets_default/text_input.dart';
import 'package:get/get.dart';

import 'ingredient_picture.dart';

class IngredientItem extends StatelessWidget {
  final String name;
  final double number;
  final String metric;
  final bool checkable;
  final bool checked;
  final Function onChecked;
  final Function onDelete;
  final Function onChangeQuantity;

  final GroceryListStates groceryListStates = Get.find();

  IngredientItem(
      {@required this.name,
      @required this.number,
      @required this.metric,
      this.onDelete,
      this.checkable = false,
      this.checked = false,
      this.onChecked,
      this.onChangeQuantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => _modalBottomSheetMenu(context),
        onLongPress: () => _modalBottomSheetMenu(context),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.05),
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Opacity(
                  opacity: checkable && checked ? 0.3 : 1.0,
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: mainColor, width: 1)),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: getIngredientImageFromName(name).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                ),
                Expanded(child: Container()),
                Stack(alignment: Alignment.center, children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    height: 3,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    width: checked ? name.length.toDouble() * 12 : 0,
                    onEnd: () async {
                      groceryListStates.updateGroceryListIngredient(
                          EntityGroceryListIngredient(
                              name: name,
                              metric: metric,
                              number: number,
                              checked: checked));
                    },
                  ),
                  AutoSizeText(
                      name +
                          " (" +
                          number
                              .toString()
                              .substring(0, number.toString().indexOf(".")) +
                          metric +
                          ")",
                      style: textAssistantH2BlackBold)
                ]),
                Expanded(child: Container()),
                checkable
                    ? Checkbox(
                        checkColor: Colors.white,
                        activeColor: mainColor,
                        value: checked,
                        onChanged: onChecked,
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                width: 20,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            FoodzIngredientPicture(
                              height: 100,
                              width: 100,
                              image: getIngredientImageFromName(name),
                            ),
                            Text(
                              name,
                              style: textAssistantH1Black,
                            ),
                            SizedBox(height: 20),
                            SpinBox(
                              min: getStepNumberFromMetric(metric),
                              max: 1000000,
                              step: getStepNumberFromMetric(metric),
                              value: number.toDouble(),
                              onChanged: onChangeQuantity,
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  onDelete();
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          );
        });
  }
}
