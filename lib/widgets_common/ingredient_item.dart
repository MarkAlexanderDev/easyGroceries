import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/utils/ingredient.dart';
import 'package:foodz/widgets_common/profile_picture.dart';
import 'package:foodz/widgets_default/text_input.dart';

class IngredientItem extends StatelessWidget {
  final String name;
  final String pictureUrl;
  final double number;
  final String metric;
  final bool checkable;
  final bool checked;
  final Function onChecked;
  final Function onDelete;
  final Function onChangeQuantity;

  IngredientItem(
      {@required this.name,
      @required this.pictureUrl,
      @required this.number,
      @required this.metric,
      this.onDelete,
      this.checkable = false,
      this.checked,
      this.onChecked,
      this.onChangeQuantity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () => _modalBottomSheetMenu(context),
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
                  child: FoodzProfilePicture(
                    height: 50,
                    width: 50,
                    pictureUrl: pictureUrl,
                    editMode: false,
                    defaultChild: Icon(
                      Icons.add_shopping_cart_outlined,
                      color: mainColor,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                AutoSizeText(
                    name +
                        " (" +
                        number
                            .toString()
                            .substring(0, number.toString().indexOf(".")) +
                        metric +
                        ")",
                    style: textAssistantH2BlackBold.copyWith(
                        decoration: checkable && checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
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
                            FoodzProfilePicture(
                              height: 100,
                              width: 100,
                              pictureUrl: pictureUrl,
                              editMode: false,
                              defaultChild: Icon(
                                Icons.add_shopping_cart_outlined,
                                color: mainColor,
                              ),
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
                            FoodzTextInput(
                                initialValue: "",
                                onChanged: (String value) {},
                                onClear: () {},
                                hint: "Comments"),
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
