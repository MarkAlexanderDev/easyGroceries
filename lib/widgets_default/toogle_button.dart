import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';
import 'package:foodz/style/text_style.dart';

class FoodzToogleButton extends StatelessWidget {
  final List<String> items;
  final onPressed;
  final int selectedItem;

  FoodzToogleButton(
      {@required this.items,
      @required this.onPressed,
      @required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      children: _buildItems(),
      onPressed: onPressed,
      isSelected: _getFormatedList(),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      highlightColor: mainColor,
      selectedBorderColor: Colors.black,
      fillColor: mainColor,
      borderWidth: 0.5,
    );
  }

  List<Widget> _buildItems() {
    final List<Widget> widgetList = [];
    for (int i = 0; i < items.length; i++) {
      widgetList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          items[i].toUpperCase(),
          style: textAssistantH2BlackBold.copyWith(
              color: i == selectedItem ? Colors.white : mainColor),
        ),
      ));
    }
    return widgetList;
  }

  _getFormatedList() {
    final List<bool> list = [false, /*false,*/ false];
    list[selectedItem] = true;
    return list;
  }
}
