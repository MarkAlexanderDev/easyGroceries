import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';
import 'package:foodz/widgets_common/profile_picture.dart';

class IngredientItem extends StatelessWidget {
  final String name;
  final String pictureUrl;
  final bool checkable;
  final bool checked;
  final Function onChecked;

  IngredientItem(
      {@required this.name,
      @required this.pictureUrl,
      this.checkable = false,
      this.checked,
      this.onChecked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
              AutoSizeText(name,
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
    );
  }
}
